{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.hardware.tpm;
in {
  options.hardware.tpm.enable = mkEnableOption "Enable tmp support";

  config = mkIf cfg.enable {
    boot.kernelModules = ["uhid"];

    security.tpm2 = {
      enable = true;
      applyUdevRules = true;
      abrmd.enable = true;
      tctiEnvironment.enable = true;
      pkcs11.enable = true;
    };

    environment.systemPackages = with pkgs; [
      tpm2-tools
      tpm2-tss
      tpm2-abrmd
    ];
  };
}
