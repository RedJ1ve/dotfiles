{
  inputs',
  pkgs,
  lib,
  ...
}: {
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
    };
  };
}
