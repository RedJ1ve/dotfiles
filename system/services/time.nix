{...}: {
  services = {
    automatic-timezoned.enable = true;

    timesyncd = {
      enable = true;
      extraConfig = "PollIntervalMinSec=128";
    };
  };

  time = {
    hardwareClockInLocalTime = false;
  };
}
