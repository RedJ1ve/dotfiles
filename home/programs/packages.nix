{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    neofetch
    nnn
    tree

    zip
    unzip
    p7zip

    xfce.thunar
    xorg.xlsclients
    vscodium

    docker-compose
    libimobiledevice
    libgcrypt
    libunistring
    libusbmuxd
    nodejs_20

    swww

    nur.repos.nltch.spotify-adblock
  ];
}
