{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot = {
    tmp.cleanOnBoot = true;

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth = rec {
      enable = true;
      theme = "connect";
      themePackages = with pkgs; [
        (
          adi1090x-plymouth-themes.override {
            selected_themes = [theme];
          }
        )
      ];
    };
  };
}
