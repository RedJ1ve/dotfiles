{
  pkgs,
  lib,
  ...
}: {
  environment = {
    defaultPackages = lib.mkForce [];

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
