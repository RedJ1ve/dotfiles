{
  pkgs,
  default,
  ...
}: {
  programs.rofi-wayland = {
    enable = true;
  };
}
