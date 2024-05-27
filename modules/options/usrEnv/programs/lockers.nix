{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.types) package;
  inherit (lib.options) mkEnableOption mkOption;

  cfg = config.modules.usrEnv.programs.screenlock;
  pkg = inputs'.hyprlock.packages.hyprlock;
in {
  options.modules.usrEnv.programs.screenlock = {
    hyprlock.enable = mkEnableOption "hyprlock screenlocker";

    package = mkOption {
      type = package;
      default = pkg;
      readOnly = true;
      description = "The screenlocker package";
    };
  };
}
