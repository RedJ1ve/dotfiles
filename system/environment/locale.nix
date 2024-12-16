{
  config,
  pkgs,
  ...
}: {
  services.xserver.xkb.layout = "gb";

  i18n = let
    defaultLocale = "en_US.UTF-8";
    gb = "en_GB.UTF-8";
  in {
    inherit defaultLocale;

    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = gb;
      LC_IDENTIFICATION = gb;
      LC_MEASUREMENT = gb;
      LC_MONETARY = gb;
      LC_NAME = gb;
      LC_NUMERIC = gb;
      LC_PAPER = gb;
      LC_TELEPHONE = gb;
      LC_TIME = gb;
    };

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
    ];

    # ime configuration
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-lua
        libsForQt5.fcitx5-qt

        # themes
        fcitx5-material-color
      ];
    };
  };
}
