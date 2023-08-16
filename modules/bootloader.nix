{
  config,
  pkgs,
  ...
}: {
  boot = {
    tmp.cleanOnBoot = true;

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["v4l2loopback"];

    loader = {
      timeout = 5;

      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
        useOSProber = true;
        extraEntries = ''
          menuentry "Reboot" {
          	reboot
          }
          menuentry "Poweroff" {
          	halt
          }
        '';
      };
    };
  };
}
