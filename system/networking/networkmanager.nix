{
  networking.networkmanager = {
    enable = true;
    unmanaged = ["rndis0"];
    wifi = {
      macAddress = "random";
      powersave = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
