{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.hardware.gpu.amd;
in {
  options.hardware.gpu.amd.enable = mkEnableOption "Enable amd gpu drivers";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.amd
      xorg.xf86videoamdgpu
    ];

    boot = {
      initrd.kernelModules = [
        "amdgpu"
      ];

      kernelModules = [
        "amdgpu"
      ];
    };

    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          amdvlk

          mesa

          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer

          rocmPackages.clr
        ];

        extraPackages32 = with pkgs.pkgsi686Linux; [
          amdvlk
        ];
      };

      amdgpu = {
        initrd.enable = true;

        amdvlk = {
          enable = true;
          support32Bit.enable = true;
          supportExperimental.enable = true;
        };
      };
    };
  };
}
