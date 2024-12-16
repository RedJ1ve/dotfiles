{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.networking.wifi;
in {
  options.networking.wifi.enable = mkEnableOption "Enable wifi";

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        unmanaged = ["rndis0"];
        wifi = {
          macAddress = "stable";
          scanRandMacAddress = true;
          powersave = true;
        };

        ethernet.macAddress = "random";
      };

      enableIPv6 = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
