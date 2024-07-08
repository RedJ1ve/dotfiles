{
  boot = {
    initrd.availableKernelModules = [
      "aesni_intel"
      "cryptd"
      "usb_storage"
    ];

    kernelParams = [
      "luks.options=timeout=0"
      "rd.luks.options=timeout=0"
      "rootflags=x-systemd.device-timeout=0"
    ];
  };

  services.lvm.enable = true;
}
