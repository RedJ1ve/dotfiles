{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.graphical;
in {
  config = mkIf cfg.enable {
    services.greetd = let
      session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "aecyr";
      };
    in {
      enable = true;
      settings = {
        default_session = session;
        initial_session = session;
        terminal.vt = 1;
      };
    };
  };
}
