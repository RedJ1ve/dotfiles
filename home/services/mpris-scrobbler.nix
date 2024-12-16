{ pkgs, ... }: {
  home.packages = with pkgs; [
    mpris-scrobbler
  ];

  systemd.user.services.mpris-scrobbler = {
    Unit = {
      Description = "mpris-scrobbler";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.mpris-scrobbler}/bin/mpris-scrobbler";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
