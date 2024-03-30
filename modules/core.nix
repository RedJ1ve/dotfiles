{
  pkgs,
  lib,
  ...
}: {
  documentation.nixos.enable = false;

  virtualisation.docker.enable = true;

  hardware.opengl.driSupport32Bit = true ;
  hardware.opentabletdriver.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = lib.mkDefault "23.05";

  time.timeZone = lib.mkDefault "Europe/London";

  users.users.aecyr = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
  };

  console.keyMap = lib.mkDefault "uk";
}
