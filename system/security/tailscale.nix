{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.tailscale = mkOption {
    description = "Use tailscale";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.tailscale {
    services.tailscale.enable = true;

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
