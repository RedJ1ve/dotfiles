{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
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
}
