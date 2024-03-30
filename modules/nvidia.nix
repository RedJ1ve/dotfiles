{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    cpu.intel.updateMicrocode = true;

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
      "intel_iommu=on"
      "iommu=pt"
      "i915.enable_gvt=1"
      "kvm.ignore_msrs=1"
    ];

   kernelModules = [
      "i915"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "vfoi-pci"
      "kvm-intel"
    ];

    initrd.kernelModules = [
      "i915"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "vfio-pci"
      "kvm-intel"
    ];

    extraModprobeConfig = "options nvidia-drm modeset=1";
    blacklistedKernelModules = ["nouveau"];
  };
}
