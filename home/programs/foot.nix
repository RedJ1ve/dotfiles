{
  inputs',
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    libsixel
  ];

  programs.foot = {
    enable = true;
    package = inputs'.nyxexprs.packages.foot-transparent;
    server.enable = false;

    settings = {
      main = {
        term = "xterm-256color";
        pad = "4x4 center";

        selection-target = "clipboard";

        dpi-aware = true; # this looks more readable on a laptop, but it's unreasonably large
        font = "AestheticIosevka Nerd Font:size=10";
        font-bold = "AestheticIosevka Nerd Font:size=10";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      desktop-notifications = {
        command = "${lib.getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };

      tweak = {
        font-monospace-warn = "no";
        sixel = "yes";
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
      };

      mouse.hide-when-typing = "yes";

      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
        protocols = "http, https, ftp, ftps, file, mailto, ipfs";
      };

      colors.alpha = 0.7;
    };
  };
}
