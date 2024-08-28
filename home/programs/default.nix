{pkgs, ...}: {
  imports = [
    ./anyrun
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
    p7zip
    ventoy-full
    zenity
    protontricks
    winetricks
    openal
    gnome.nautilus
  ];
}
