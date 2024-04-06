{
  pkgs,
  config,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    nvidia = {
      open = false;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      modesetting.enable = true;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "535.171.04";
        ibtSupport = true;
        sha256_64bit = "sha256-6PFkO0vJXYrNZaRHB4SpfazkZC8UkjZGYSDbKqlCQ3o=";
        sha256_aarch64 = "sha256-k7k22z5PYZdBVfuYXVcl9SFUMqZmK4qyxoRwlYyRdgU=";
        openSha256 = "sha256-dktHCoESqoNfu5M73aY5MQGROlZawZwzBqs3RkOyfoQ=";
        settingsSha256 = "sha256-qNjfsT9NGV151EHnG4fgBonVFSKc4yFEVomtXg9uYD4=";
        persistencedSha256 = "sha256-ci86XGlno6DbHw6rkVSzBpopaapfJvk0+lHcR4LDq50=";
      };
    };

    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver libvdpau-va-gl vaapiVdpau];
  };

  boot = {
    kernelParams = [
      "ibt=off"
      "fbdev=1"
    ];

    blacklistedKernelModules = ["nouveau"];
  };
}
