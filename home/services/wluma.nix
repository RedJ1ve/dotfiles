{ pkgs, ... }: {
  systemd.user.services.wluma = {
    Unit = {
      Description = "Automatic backlight control";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.wluma}/bin/wluma";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  xdg.configFile."wluma/config.toml".source = (pkgs.formats.toml {}).generate "wluma-config" {
    als.webcam = {
      video = 0;
      thresholds = {
        "45" = "normal";
        "15" = "dark";
        "75" = "outdoors";
        "60" = "bright";
        "30" = "dim";
        "0" = "night";
      };
    };

    output.backlight = [
      {
        capturer = "none";
        name = "eDP-1";
        path = "/sys/class/backlight/amdgpu_bl1";
      }
    ];
  };
}
