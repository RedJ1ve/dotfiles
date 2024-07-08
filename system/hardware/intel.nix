{pkgs, ...}: {
  hardware.cpu.intel.updateMicrocode = true;

  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = ["i915.fastboot=1" "enable_gvt=1"];
  };

  # gpu stuff

  environment.systemPackages = with pkgs; [intel-gpu-tools];
  boot.initrd.kernelModules = ["i915"];
  services.xserver.videoDrivers = ["modesetting"];

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      # intel-compute-runtime # FIXME does not build due to unsupported system
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
