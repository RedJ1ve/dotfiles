{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
  };

  boot = {
    kernelParams = [
      "nvidia_drm.modeset=1"
      "rd.driver.blacklist=nouveau"
      "modprobe.blacklist=nouveau"
      "ibt=off"
    ];

    initrd.kernelModules = [
      "i915"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    extraModprobeConfig = "options nvidia-drm modeset=1";
    blacklistedKernelModules = ["nouveau"];
  };
}
