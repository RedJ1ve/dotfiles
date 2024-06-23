{inputs', ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs'.hyprland.packages.hyprland;
    portalPackage = inputs'.xdg-desktop-portal-hyprland.packages.xdg-desktop-portal-hyprland;
  };
}
