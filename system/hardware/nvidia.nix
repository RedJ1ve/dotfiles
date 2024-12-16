{
  config,
  pkgs,
  lib,
  ...
}: {
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
        finegrained = true;
      };
      prime = {
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      open = true;
      nvidiaSettings = false;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    graphics = {
      extraPackages = with pkgs; [nvidia-vaapi-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
    };
  };
}
