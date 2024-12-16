{pkgs, ...}: {
  systemd.user.services.qbittorrent-nox = {
    Unit = {
      Description = "qbittorrent-nox";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
