{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) bool;
in {
  imports = [
    ./apparmor.nix
    ./encryption.nix
    ./filesystem.nix
    ./kernel.nix
    ./networking.nix
    ./pam.nix
    ./sudo.nix
    ./usbguard.nix
  ];

  options.security.enable = mkOption {
    description = "Enable security options";
    type = bool;
    default = true;
  };
}
