{
  inputs',
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    portalPackage = inputs'.xdg-desktop-portal-hyprland.packages.default;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
