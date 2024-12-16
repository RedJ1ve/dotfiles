{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      curl
      wget
      micro
      yazi
      pciutils
      lshw
      rsync
    ];
  };
}
