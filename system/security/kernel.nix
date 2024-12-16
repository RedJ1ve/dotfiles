{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.kernel = mkOption {
    description = "Secure kernel";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.kernel {
    security = {
      protectKernelImage = false;
      lockKernelModules = false;
      forcePageTableIsolation = true;
    };

    boot.kernel.sysctl = {
      # Hide kernel pointers from processes without the CAP_SYSLOG capability.
      "kernel.kptr_restrict" = 1;
      "kernel.printk" = "3 3 3 3";
      # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability.
      "dev.tty.ldisc_autoload" = 0;
      # Make it so a user can only use the secure attention key which is required to access root securely.
      "kernel.sysrq" = 0;
      # Protect against SYN flooding.
      "net.ipv4.tcp_syncookies" = 1;
      # Protect against time-wait assasination.
      "net.ipv4.tcp_rfc1337" = 1;

      # Enable strict reverse path filtering (that is, do not attempt to route
      # packets that "obviously" do not belong to the iface's network; dropped
      # packets are logged as martians).
      "net.ipv4.conf.all.log_martians" = true;
      "net.ipv4.conf.all.rp_filter" = "1";
      "net.ipv4.conf.default.log_martians" = true;
      "net.ipv4.conf.default.rp_filter" = "1";

      # Protect against SMURF attacks and clock fingerprinting via ICMP timestamping.
      "net.ipv4.icmp_echo_ignore_all" = "1";

      # Ignore incoming ICMP redirects (note: default is needed to ensure that the
      # setting is applied to interfaces added after the sysctls are set)
      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      "net.ipv4.conf.default.accept_redirects" = false;
      "net.ipv4.conf.default.secure_redirects" = false;
      "net.ipv6.conf.all.accept_redirects" = false;
      "net.ipv6.conf.default.accept_redirects" = false;

      # Ignore outgoing ICMP redirects (this is ipv4 only)
      "net.ipv4.conf.all.send_redirects" = false;
      "net.ipv4.conf.default.send_redirects" = false;

      # Restrict abritrary use of ptrace to the CAP_SYS_PTRACE capability.
      "kernel.yama.ptrace_scope" = 2;
      "net.core.bpf_jit_enable" = false;
      "kernel.ftrace_enabled" = false;

      # Avoid kernel memory address exposures via dmesg (this value can also be set by CONFIG_SECURITY_DMESG_RESTRICT).
      "kernel.dmesg_restrict" = 1;

      # Prevent creating files in potentially attacker-controlled environments such
      # as world-writable directories to make data spoofing attacks more difficult
      "fs.protected_fifos" = 2;

      # Prevent unintended writes to already-created files
      "fs.protected_regular" = 2;

      # Disable SUID binary dump
      "fs.suid_dumpable" = 0;

      # Prevent unprivileged users from creating hard or symbolic links to files
      "fs.protected_symlinks" = 1;
      "fs.protected_hardlinks" = 1;

      # Disallow profiling at all levels without CAP_SYS_ADMIN
      "kernel.perf_event_paranoid" = 3;

      # Require CAP_BPF to use bpf
      "kernel.unprivileged_bpf_disabled" = true;

      # Kexec allows replacing the current running kernel. There may be an edge case where
      # you wish to boot into a different kernel, but I do not require kexec. Disabling it
      # patches a potential security hole in our system.
      "kernel.kexec_load_disabled" = true;

      # Borrowed by NixOS/nixpkgs. Since the security module does not explain what those
      # options do, it is up you to educate yourself dear reader.
      # See:
      #  - <https://docs.kernel.org/admin-guide/sysctl/vm.html#mmap-rnd-bits>
      #  - <https://docs.kernel.org/admin-guide/sysctl/vm.html#mmap-min-addr>
      "vm.mmap_rnd_bits" = 32;
      "vm.mmap_min_addr" = 65536;
    };

    # Security
    boot.blacklistedKernelModules = [
      # Obscure network protocols
      "dccp" # Datagram Congestion Control Protocol
      "sctp" # Stream Control Transmission Protocol
      "rds" # Reliable Datagram Sockets
      "tipc" # Transparent Inter-Process Communication
      "n-hdlc" # High-level Data Link Control
      "netrom" # NetRom
      "x25" # X.25
      "ax25" # Amateur X.25
      "rose" # ROSE
      "decnet" # DECnet
      "econet" # Econet
      "af_802154" # IEEE 802.15.4
      "ipx" # Internetwork Packet Exchange
      "appletalk" # Appletalk
      "psnap" # SubnetworkAccess Protocol
      "p8022" # IEEE 802.3
      "p8023" # Novell raw IEEE 802.3
      "can" # Controller Area Network
      "atm" # ATM
      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "vivid"
      "gfs2"
      "ksmbd"
      "nfsv4"
      "nfsv3"
      "cifs"
      "nfs"
      "cramfs"
      "freevxfs"
      "jffs2"
      "hfs"
      "hfsplus"
      "squashfs"
      "udf"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
    ];

    boot.kernelParams = [
      # make stack-based attacks on the kernel harder
      "randomize_kstack_offset=on"

      # Disable vsyscalls as they are obsolete and have been replaced with vDSO.
      # vsyscalls are also at fixed addresses in memory, making them a potential
      # target for ROP attacks
      # this breaks really old binaries for security
      "vsyscall=none"

      # reduce most of the exposure of a heap attack to a single cache
      # Disable slab merging which significantly increases the difficulty of heap
      # exploitation by preventing overwriting objects from merged caches and by
      # making it harder to influence slab cache layout
      "slab_nomerge"

      # Disable debugfs which exposes a lot of sensitive information about the
      # kernel. Some programs, such as powertop, use this interface to gather
      # information about the system, but it is not necessary for the system to
      # actually publish those. I can live without it.
      "debugfs=off"

      # Sometimes certain kernel exploits will cause what is known as an "oops".
      # This parameter will cause the kernel to panic on such oopses, thereby
      # preventing those exploits
      "oops=panic"

      # Only allow kernel modules that have been signed with a valid key to be
      # loaded, which increases security by making it much harder to load a
      # malicious kernel module
      "module.sig_enforce=1"

      # The kernel lockdown LSM can eliminate many methods that user space code
      # could abuse to escalate to kernel privileges and extract sensitive
      # information. This LSM is necessary to implement a clear security boundary
      # between user space and the kernel
      #  integrity: kernel features that allow userland to modify the running kernel
      #             are disabled
      #  confidentiality: kernel features that allow userland to extract confidential
      #             information from the kernel are also disabled
      # ArchWiki recommends opting in for "integrity", however since we avoid modifying
      # running kernel (by the virtue of using NixOS and locking module hot-loading) the
      # confidentiality mode is a better solution.
      "lockdown=confidentiality"

      # enable buddy allocator free poisoning
      #  on: memory will befilled with a specific byte pattern
      #      that is unlikely to occur in normal operation.
      #  off (default): page poisoning will be disabled
      "page_poison=on"

      # performance improvement for direct-mapped memory-side-cache utilization
      # reduces the predictability of page allocations
      "page_alloc.shuffle=1"

      # for debugging kernel-level slab issues
      "slub_debug=FZP"

      # ignore access time (atime) updates on files
      # except when they coincide with updates to the ctime or mtime
      "rootflags=noatime"

      # linux security modules
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"

      # prevent the kernel from blanking plymouth out of the fb
      "fbcon=nodefer"

      # the format that will be used for integrity audit logs
      #  0 (default): basic integrity auditing messages
      #  1: additional integrity auditing messages
      "integrity_audit=1"
    ];
  };
}
