{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.apparmor = mkOption {
    description = "Enable apparmor";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.apparmor {
    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };
}
