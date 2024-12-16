{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.mountOptions = mkOption {
    description = "Set secure mount options on important directories";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.mountOptions {
    fileSystems = let
      defaults = ["nodev" "nosuid" "noexec"];
    in {
      "/var/log".options = defaults;
      "/boot".options = defaults;
    };
  };
}
