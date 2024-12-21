{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkForce mkEnableOption;

  cfg = config.boot.secureboot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  options.boot.secureboot.enable = mkEnableOption "Enables secureboot using lanzaboote";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [sbctl];

    boot = {
      loader.systemd-boot.enable = mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
