{pkgs, ...}: {
  config.modules.system = {
    mainUser = "aecyr";
    fs.enabledFilesystems = ["btrfs" "vfat"];
    autoLogin = false;

    boot = {
      loader = "systemd-boot";
      secureBoot = false;
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      loadRecommendedModules = true;
      tmpOnTmpfs = false;
      plymouth = {
        enable = false;
        # withThemes = true;
      };
    };

    video.enable = true;
    sound.enable = true;
    bluetooth.enable = false;
    printing.enable = true;
    emulation.enable = true;

    virtualization = {
      enable = true;
      qemu.enable = true;
    };

    encryption = {
    	enable = true;
    	device = "enc";
    	#device = "/dev/disk/by-uuid/08380e58-57d0-43d6-aebb-d5bf9ec98834";
    };

    networking = {
      optimizeTcp = true;
      nftables.enable = true;
      tailscale = {
        enable = false;
        isClient = false;
        isServer = false;
      };
    };

    security = {
      tor.enable = true;
      fixWebcam = false;
      lockModules = true;
      auditd.enable = true;
    };

    programs = {
      cli.enable = true;
      gui.enable = true;

      spotify.enable = true;

      gaming = {
        enable = true;
      };

      default = {
        terminal = "foot";
      };
    };
  };
}
