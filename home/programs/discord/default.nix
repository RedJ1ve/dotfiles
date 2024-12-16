{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
  ];

  xdg.configFile."vesktop/themes".source = ./themes;

  services.arrpc.enable = true;
}
