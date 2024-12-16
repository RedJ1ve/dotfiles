{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.hardware.bluetooth;
in {
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
      disabledPlugins = ["sap"];
      settings.General = {
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
        Experimental = true;
      };
    };

    services.blueman.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/114222
    systemd.user.services.telephony_client.enable = false;
  };
}
