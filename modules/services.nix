{
  config,
  pkgs,
  ...
}: {
  #virtualisation.anbox.enable = true;

  systemd = {
      packages = with pkgs; [ qbittorrent-nox jackett];
      services."qbittorrent-nox@aecyr" = {
        overrideStrategy = "asDropin";
        wantedBy = ["multi-user.target"];
      };
      services.jackett.enable = true;
    };

  services = {
    usbmuxd.enable = true;

    xserver = {
      layout = "gb";
      xkbVariant = "";
    };

    openssh = {
      enable = false;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
