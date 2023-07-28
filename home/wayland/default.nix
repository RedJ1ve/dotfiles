{
  pkgs,
  lib,
  inputs',
  ...
}: {
  imports = [
    ./hyprland
    # ./rofi.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp

    wl-clipboard
    cliphist
    rofi-wayland
  ];
}
