{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.gaming;
in {
  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };
  };
}
