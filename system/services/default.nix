{
  imports = [
    ./location.nix
    ./logrotate.nix
    ./oomd.nix
    ./power.nix
    ./time.nix
  ];

  services = {
    dbus.implementation = "broker";

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileSize=50M
    '';

    udisks2.enable = true;
    printing.enable = true;
  };
}
