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

    docker-compose
    libimobiledevice
    libgcrypt
    libunistring
    libusbmuxd

    swww

    nur.repos.nltch.spotify-adblock
  ];
}
