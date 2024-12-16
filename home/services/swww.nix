{pkgs, ...}: {
  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww-daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
