{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  options.boot.secureboot.enable = lib.mkEnableOption "Enables secureboot using lanzaboote";

  config = lib.mkIf config.boot.secureboot.enable {
    environment.systemPackages = with pkgs; [sbctl];

    boot = {
      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
