{
  keys,
  pkgs,
  ...
}: {
  # Add my SSH keys to initrd for remote unlocking. Backdoor?!
  boot.initrd.network.ssh.authorizedKeys = [keys.aecyr];

  users.users.aecyr = {
    isNormalUser = true;

    # Home directory
    createHome = true;
    home = "/home/aecyr";

    shell = pkgs.zsh;

    # Should be generated manually. See option documentation
    # for tips on generating it. For security purposes, it's
    # a good idea to use a non-default hash.
    initialHashedPassword = "$y$j9T$lYeQEVIjnXba1VOHT1URm1$GPUXwoCoa7oBidbs4PDOdUOiFKM/8iKfDwhgdzfrOc5";
    openssh.authorizedKeys.keys = [keys.aecyr];
    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "plugdev"
      "lp"
      "tss"
      "power"
      "nix"
      "network"
      "networkmanager"
      "wireshark"
      "git"
      "libvirtd"
    ];
  };
}
