{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [./config.nix];

  home.packages = with pkgs; [
    xorg.xprop
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix];
  };
}
