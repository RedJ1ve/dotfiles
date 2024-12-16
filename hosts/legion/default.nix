{
  imports = [
    ./hardware-configuration.nix

    ./kernel
  ];

  users.users.aecyr = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  boot = {
    secureboot.enable = true;
    plymouth.enable = true;
  };

  gaming.enable = true;

  hardware = {
    bluetooth.enable = true;
    tpm.enable = true;

    cpu.amd.enable = true;

    gpu = {
      amd.enable = true;

      nvidia = {
        enable = true;
        hybrid = true;
        bus = {
          amd = "PCI:5:0:0";
          nvidia = "PCI:1:0:0";
        };
      };
    };
  };

  networking.wifi.enable = true;

  security.enable = true;

  graphical.enable = true;

  system.stateVersion = "24.05";
}
