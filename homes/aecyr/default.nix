{
  imports = [
    ./de
  ];

  config = {
    home = {
      username = "aecyr";
      homeDirectory = "/home/aecyr";

      # This is, and should remain, the version on which you have initiated
      # the home-manager configuration. Similar to the `stateVersion` in the
      # NixOS module system, you should not be changing it.
      # I will personally strangle every moron who just puts nothing but "DONT CHANGE" next
      # to this value
      stateVersion = "23.11";
    };

    manual = {
      # Try to save some space by not installing variants of the home-manager
      # manual, which I don't use at all. Unlike what the name implies, this
      # section is for home-manager related manpages only, and does not affect
      # whether or not manpages of actual packages will be installed.
      manpages.enable = false;
      html.enable = false;
      json.enable = false;
    };

    # let HM manage itself when in standalone mode
    programs.home-manager.enable = true;

    # reload system units when changing configs
    systemd.user.startServices = "sd-switch"; # or "legacy" if "sd-switch" breaks again
  };
}
