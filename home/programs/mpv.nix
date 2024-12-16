{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    config = {
      force-window = true;
      hidpi-window-scale = false;
      hwdec = "auto";
      border = "no";
    };
  };
}
