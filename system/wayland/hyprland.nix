{
  config,
  inputs',
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.graphical;
in {
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
    };
  };
}
