{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.gaming;
in {
  config = mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
}
