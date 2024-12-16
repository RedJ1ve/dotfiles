{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./gamescope.nix
    ./gamemode.nix
    ./steam.nix
  ];

  options.gaming.enable = mkEnableOption "Installs Steam, and other gaming tools";
}
