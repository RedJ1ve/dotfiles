{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.hardware.cpu.intel;
in {
  options.hardware.cpu.intel.enable = mkEnableOption "Enable intel cpu improvements";

  config = mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = true;

    boot = {
      kernelModules = [
        "kvm-intel"
      ];

      kernelParams = [
        "i915.fastboot=1"
        "enable_gvt=1"
      ];
    };
  };
}
