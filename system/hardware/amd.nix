{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    amdctl
    nvtopPackages.amd
    xorg.xf86videoamdgpu
  ];

  hardware.cpu.amd.updateMicrocode = true;

  boot = {
    initrd.kernelModules = [
      "amdgpu"
    ];

    kernelModules = [
      "amd-pstate"
      "amdgpu"
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
}
