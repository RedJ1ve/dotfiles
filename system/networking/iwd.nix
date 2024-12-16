{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.networking.iwd;
in {
  options.networking.iwd.enable = mkOption {
    description = "Enable iwd WiFi backend";
    type = bool;
    default = config.networking.wifi.enable;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [iwgtk];

    networking = {
      wireless.iwd = {
        enable = true;

        settings = {
          Scan.DisablePeriodicScan = false;
          Settings.AutoConnect = true;
          IPv6.Enabled = true;

          General = {
            AddressRandomization = "network";
            AddressRandomizationRange = "full";
            EnableNetworkConfiguration = true;
            RoamRetryInterval = 15;
          };

          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
        };
      };

      networkmanager.wifi.backend = "iwd";
    };

    systemd.user.services.iwgtk = {
      serviceConfig.ExecStart = "${lib.getExe pkgs.iwgtk} -i";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
    };
  };
}
