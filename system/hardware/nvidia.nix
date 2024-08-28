{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

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
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = false;
      nvidiaPersistenced = true;
      forceFullCompositionPipeline = true;
    };

    graphics = {
      extraPackages = with pkgs; [nvidia-vaapi-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
    };
  };
}
