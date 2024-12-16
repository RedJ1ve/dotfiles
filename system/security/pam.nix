{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.pam = mkOption {
    description = "Enable secure authentication";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.pam {
    security.pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services.hyprlock.text = "auth include login";
    };
  };
}
