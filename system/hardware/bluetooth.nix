{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    settings.General = {
      JustWorksRepairing = "always";
      MultiProfile = "multiple";
      Experimental = true;
    };
  };

  services.blueman.enable = true;
}
