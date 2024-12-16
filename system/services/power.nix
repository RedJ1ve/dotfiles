{
  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
