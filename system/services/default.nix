{
  imports = [
    ./greetd.nix
    ./location.nix
    ./logrotate.nix
    ./oomd.nix
    ./pipewire.nix
    ./power.nix
    ./time.nix
    ./xserver.nix
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
