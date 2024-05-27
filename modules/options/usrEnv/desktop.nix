{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool enum package;

  cfg = config.modules.usrEnv;
  sys = config.modules.system;
in {
  options.modules.usrEnv = {
    desktop = mkOption {
      type = enum ["none" "Hyprland"];
      default = "none";
      description = ''
        The desktop environment to be used.
      '';
    };

    desktops = {
      hyprland = {
        enable = mkOption {
          type = bool;
          default = cfg.desktop == "Hyprland";
          description = ''
            Whether to enable Hyprland wayland compositor.

            Will be enabled automatically when `modules.usrEnv.desktop`
            is set to "Hyprland".

          '';
        };

        package = mkOption {
          type = package;
          default = inputs'.hyprland.packages.hyprland;
          description = ''
            The Hyprland package to be used.
          '';
        };
      };
    };

    useHomeManager = mkOption {
      type = bool;
      default = true;
      description = ''
        Whether to enable the usage of home-manager for user home
        management. My home-manager module will map the list of users to
        their home directories inside the `homes/` directory in the
        repository root.

        ::: {.warning}
        Username via `modules.system.mainUser` must be set if
        this option is enabled.
        :::
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.useHomeManager -> sys.mainUser != null;
        message = "modules.system.mainUser must be set while modules.usrEnv.useHomeManager is enabled";
      }
    ];
  };
}
