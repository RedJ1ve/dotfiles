{pkgs, ...}: {
  home.packages = [
    (pkgs.discord-canary.override {
      nss = pkgs.nss_latest;
      withOpenASAR = true;
      withVencord = true;
    })
  ];

  services.arrpc.enable = true; 
}
