{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption mkDefault mkForce;
  inherit (lib.types) str;
  cfg = config.hardware.gpu.nvidia;
in {
  options.hardware.gpu.nvidia = {
    enable = mkEnableOption "Enable nvidia gpu drivers";
    hybrid = mkEnableOption "Enable hybrid graphics";
    bus = {
      amd = mkOption {
        type = str;
        default = "";
      };
      intel = mkOption {
        type = str;
        default = "";
      };
      nvidia = mkOption {
        type = str;
        default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = lib.mkForce true;

    services.xserver.videoDrivers = ["nvidia"];

    boot = {
      blacklistedKernelModules = ["nouveau"];
      kernelParams = [
        "nvidia_drm.fbdev=1"
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];
    };

    environment = {
      sessionVariables.LIBVA_DRIVER_NAME = "nvidia";

      systemPackages = with pkgs; [
        nvtopPackages.nvidia

        mesa

        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer

        libva
        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement = {
          enable = true;
          finegrained = mkDefault true;
        };
        prime = mkIf cfg.hybrid {
          amdgpuBusId = cfg.bus.amd;
          intelBusId = cfg.bus.intel;
          nvidiaBusId = cfg.bus.nvidia;
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
        open = mkDefault true;
        nvidiaSettings = mkForce false;
        nvidiaPersistenced = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
