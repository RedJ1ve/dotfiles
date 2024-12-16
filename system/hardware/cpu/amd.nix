{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.hardware.cpu.amd;
in {
  options.hardware.cpu.amd.enable = mkEnableOption "Enable amd cpu improvements";

  config = mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = true;

    boot = {
      kernelModules = [
        "amd-pstate"
        "kvm-amd"
        "msr"
        "zenpower"
      ];

      kernelParams = [
        "amd_iommu=on"
        "amd_pstate=active"
      ];

      extraModulePackages = [
        config.boot.kernelPackages.zenpower
      ];
    };
  };
}
