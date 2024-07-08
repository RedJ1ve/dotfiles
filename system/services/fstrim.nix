{
  services.fstrim.enable = true;

  systemd.services.fstrim = {
    unitConfig.ConditionACPower = true;

    serviceConfig = {
      Nice = 19; # lowest priority, be nice to other processes
      IOSchedulingClass = "idle";
    };
  };
}
