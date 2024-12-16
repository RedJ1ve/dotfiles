{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.graphical;
in {
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = false;
        lightdm.enable = false;
      };
    };
  };
}
