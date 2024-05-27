{lib, ...}: let
  inherit (lib) mkService;
  inherit (lib.options) mkEnableOption;
in {
  imports = [
    ./networking.nix
    ./social.nix
  ];
}
