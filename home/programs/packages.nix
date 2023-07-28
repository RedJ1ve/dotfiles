{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch
    nnn
    tree

    zip
    unzip
    p7zip

    webcord-vencord
    xfce.thunar
  ];
}