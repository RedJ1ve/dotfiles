{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.encryption = mkOption {
    description = "Enable services needed for encryption";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.encryption {
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
  };
}
