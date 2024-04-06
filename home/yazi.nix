{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi/yazi.toml".source = ./yazi.toml;
}
