{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.usrEnv.programs.launchers = {
    anyrun.enable = mkEnableOption "anyrun application launcher";
  };
}
