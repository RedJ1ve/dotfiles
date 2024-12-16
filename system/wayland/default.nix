{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./services

    ./environment.nix
    ./fonts.nix
    ./hyprland.nix
    ./video.nix
  ];

  options.graphical.enable = mkEnableOption "Enable window manager and associated apps and sercices";
}
