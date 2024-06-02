{pkgs, ...}: {
  imports = [
    ./hyprland
    ./foot.nix
    ./schizofox.nix
    ./vesktop.nix
    ./minecraft.nix
    ./fuzzel.nix
  ];

  home.packages = with pkgs; [
    ventoy
  ];
}
