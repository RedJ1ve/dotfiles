{
  config,
  inputs,
  pkgs,
  ...
}: let
  shyfox = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "6488ff1934c184a7b81770c67f5c3b5e983152e3";
    hash = "sha256-9InO33jS+YP+aupQc8OadvGSyXEIBcTbN8kTo91hAbY=";
  };
in {
  imports = [
    inputs.schizofox.homeManagerModule
  ];

  programs.schizofox = {
    enable = true;

    security = {
      sanitizeOnShutdown.enable = false;
      sandbox = false;
    };

    misc = {
      drm.enable = true;
      disableWebgl = false;
    };

    extensions = {
      darkreader.enable = true;
      enableDefaultExtensions = true;
      enableExtraExtensions = true;

      extraExtensions = {
        "keepassxc-browser@keepassxc.org".install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc_browser/latest.xpi";
        "jid0-dsq67mf5kjjhiiju2dfb6kk8dfw@jetpack".install_url = "https://addons.mozilla.org/firefox/downloads/latest/turbu_download_manager/latest.xpi";
        "userchrome-toggle-extended@n2ezr.ru".install_url = "https://addons.mozilla.org/firefox/downloads/file/4341014/userchrome_toggle_extended-2.0.1.xpi";
        "{3c078156-979c-498b-8990-85f7987dd929}".install_url = "https://addons.mozilla.org/firefox/downloads/file/4246774/sidebery-5.2.0.xpi";
      };
    };

    theme = {
      defaultUserChrome.enable = false;
      defaultUserContent.enable = false;
    };
  };

  home.file.".mozilla/firefox/schizo.default/chrome".source = "${shyfox}/chrome";
}
