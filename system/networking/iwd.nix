{
  pkgs,
  lib,
  ...
}: {
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
          AdressRandomizationRange = "full";
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
}
