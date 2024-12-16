{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./plymouth.nix
    ./secureboot.nix
    ./systemd-boot.nix
  ];

  boot = {
    consoleLogLevel = 3;
    swraid.enable = lib.mkForce false;

    loader = {
      timeout = lib.mkForce 0;
      generationsDir.copyKernels = true;
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = false;
    };

    initrd = {
      verbose = false;

      compressor = "zstd";
      compressorArgs = ["-19" "-T0"];

      systemd = {
        enable = true;
        strip = true;

        storePaths = with pkgs; [
          util-linux
          pciutils
        ];

        extraBin = {
          fdisk = "${pkgs.util-linux}/bin/fdisk";
          lsblk = "${pkgs.util-linux}/bin/lsblk";
          lspci = "${pkgs.pciutils}/bin/lspci";
        };
      };

      kernelModules = [
        "ahci"
        "nvme"
        "xhci_pci"
        "btrfs"
        "sd_mod"
        "dm_mod"
        "tpm"
      ];

      # the set of kernel modules in the initial ramdisk used during the boot process
      availableKernelModules = [
        "usbhid"
        "sd_mod"
        "sr_mod"
        "dm_mod"
        "uas"
        "usb_storage"
        "rtsx_usb_sdmmc"
        "rtsx_pci_sdmmc" # Realtek PCI-Express SD/MMC Card Interface driver
        "ata_piix"
        "virtio_pci"
        "virtio_scsi"
        "ehci_pci"
      ];
    };

    kernelParams = [
      # default params
      "pti=auto"
      "idle=nomwait"
      "iommu=pt"
      "usbcore.autosuspend=-1"
      "noresume"
      "apci_backlight=native"
      "fbcon=nodefer"
      "vt.global_cursor_default=0"
      "logo.nologo"

      # silent boot
      "quiet"
      "loglevel=3"
      "udev.loglevel=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "rd.systemd.show_status=auto"
    ];
  };
}
