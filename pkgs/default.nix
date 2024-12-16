{
  perSystem = {pkgs, ...}: {
    packages = {
      wl-ocr = pkgs.callPackage ./wl-ocr {};

      # Currently not wokring as some dependencies are not packages in nixpkgs
      # gamma-launcher = pkgs.callPackage ./gamma-launcher {};
    };
  };
}
