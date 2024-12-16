{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.graphical;
in {
  config = mkIf cfg.enable {
    systemd.services.seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${lib.getExe pkgs.seatd} -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
