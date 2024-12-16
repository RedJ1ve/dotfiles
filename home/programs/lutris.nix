{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    proton-ge-bin
  ];
}
