{
  config,
  pkgs,
  ...
}: let
  inherit (config.networking) hostName;
  inherit (pkgs.callPackage ./package.nix {inherit hostName;}) xanmod_custom;
in {
  imports = [./config];
  config = {
    boot.kernelPackages = pkgs.linuxPackagesFor xanmod_custom;
  };
}
