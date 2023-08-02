{pkgs, inputs, ...}: {
  
  home.packages = with pkgs; [
    neofetch
    nnn
    tree

    zip
    unzip
    p7zip

    stable.webcord-vencord
    xfce.thunar
    xorg.xlsclients
  ];
}
