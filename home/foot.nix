{pkgs, ...}: {
  home.packages = with pkgs; [
    libsixel
  ];

  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        locked-title = "no";
        term = "xterm-256color";
        font = "monospace:size=10.5";
        vertical-letter-offset = "-0.75";
        pad = "8x6 center";
        resize-delay-ms = 100;
        selection-target = "primary";
        dpi-aware = "yes";
        bold-text-in-bright = "no";
        word-delimiters = ",│`|:\"'()[]{}<>";
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";

        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };

      mouse.hide-when-typing = true;
    };
  };
}
