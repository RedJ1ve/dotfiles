{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.usbguard = mkOption {
    description = "Enable usbguard";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.usbguard {
    services.usbguard = {
      IPCAllowedUsers = ["root"];
      IPCAllowedGroups = ["@wheel"];
      presentDevicePolicy = "allow";
      rules = ''
        allow with-interface equals { 08:*:* }

        # Reject devices with suspicious combination of interfaces
        reject with-interface all-of { 08:*:* 03:00:* }
        reject with-interface all-of { 08:*:* 03:01:* }
        reject with-interface all-of { 08:*:* e0:*:* }
        reject with-interface all-of { 08:*:* 02:*:* }
      '';
    };

    environment.systemPackages = [pkgs.usbguard];
  };
}
