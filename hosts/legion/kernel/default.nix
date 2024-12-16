{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lists) filter;
  inherit (lib.strings) hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;
in {
  # Autodiscover Nix files containing patch configurations
  # with patchfiles or extraStructuredConfig. This is not the
  # most optimized way to do it, but it works.
  # imports = filter (hasSuffix ".nix") (listFilesRecursive ./config);

  /*
     boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_xanmod_latest.override {
    ignoreConfigErrors = true;
  });
  */

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
