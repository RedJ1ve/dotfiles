{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.gaming;
in {
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;

      #gamescopeSession.enable = true;

      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
