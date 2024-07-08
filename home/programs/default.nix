{pkgs, ...}: {
  imports = [
    ./discord

    ./foot.nix
    ./fuzzel.nix
    ./schizofox.nix
    ./transient-services.nix
    ./minecraft.nix
  ];

  home.packages = with pkgs; [
    heroic
    wineWowPackages.stagingFull
    unrar
    unzip
    ventoy-full
    gnome.zenity
  ];
}
