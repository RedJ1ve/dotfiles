{
  inputs',
  pkgs,
  ...
}: let
  packages = {
    inherit (inputs'.hyprland-contrib.packages) grimblast;
    inherit (inputs'.hyprpicker.packages) hyprpicker;

    hyprshot = pkgs.callPackage ./hyprshot.nix {};
    dbus-hyprland-env = pkgs.callPackage ./dbus-hyprland-env.nix {};
  };
in
  packages
