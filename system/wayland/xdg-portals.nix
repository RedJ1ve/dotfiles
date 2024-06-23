{
  config,
  inputs',
  pkgs,
  ...
}: {
  config = {
    services.displayManager.sessionPackages = inputs'.hyprland.packages.hyprland;
    xdg.portal = {
      enable = true;
      configPackages = [inputs'.hyprland.packages.hyprland];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      config.common = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.Screencast" = ["Hyprland"];
        "org.freedesktop.impl.portal.Screenshot" = ["Hyprland"];
      };
    };
  };
}
