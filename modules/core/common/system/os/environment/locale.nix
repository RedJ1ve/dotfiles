{
config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkDefault;

    en_SE = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/bmaupin/d64368e78cd359d309685fecbe2baf23/raw/e933a0fc2e727aa640f4a1cb1f699622876940fc/en_SE";
    hash = "sha256-ArXL+rMDVWI4Mmcw8xoRlZFXhEeSQL0tLJf5pKEOx3s=";
  };

in {
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  i18n = let
    defaultLocale = "en_US.UTF-8";
    gb = "en_GB.UTF-8";
    iso-8601 = "en_SE.UTF-8";
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
      LC_TIME = iso-8601;
    };

    supportedLocales = mkDefault [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_SE.UTF-8/UTF-8"
    ];

    # ime configuration
    inputMethod = {
      enabled = "fcitx5"; # Needed for fcitx5 to work in qt6
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-lua
        libsForQt5.fcitx5-qt

        # themes
        fcitx5-material-color
      ];
    };

        glibcLocales =
      (pkgs.glibcLocales.override {
        allLocales = false;
        locales = config.i18n.supportedLocales;
      }).overrideAttrs (_: {
        postUnpack = ''
          cp ${en_SE} $sourceRoot/localedata/locales/en_SE
          echo 'en_SE.UTF-8/UTF-8 \' >> $sourceRoot/localedata/SUPPORTED
        '';
      });

  };
}
