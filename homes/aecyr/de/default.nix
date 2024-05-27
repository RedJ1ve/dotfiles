{pkgs, ...}: {
  imports = [
    ./hyprland
    ./foot.nix
    ./schizofox.nix
  ];

  home.packages = with pkgs; [
    vesktop
    gnome.nautilus
  ];
}
