{lib, ...}: {
  systemd = {
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      extraConfig = {
        "DefaultMemoryPressureDurationSec" = "20s";
      };
    };

    services.nix-daemon.serviceConfig.OOMScoreAdjust = lib.mkDefault 350;
  };
}
