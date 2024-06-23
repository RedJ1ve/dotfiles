{
  pkgs,
  config,
  ...
}: {
  config = {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      glxinfo
      glmark2
    ];
  };
}
