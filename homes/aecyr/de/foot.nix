{pkgs, ...}: {
  home.packages = with pkgs; [
    libsixel
  ];

  programs.foot = {
    enable = true;
    server.enable = false;
  };
}
