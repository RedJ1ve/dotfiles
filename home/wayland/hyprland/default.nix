{
  inputs',
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
    nvidiaPatches = true;
    xwayland = {
      enable = true;
      hidpi = false;
    };
  };
}
