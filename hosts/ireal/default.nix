{
  config,
  withSystem,
  mkNixos,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.ireal = withSystem system (
    {pkgs, ...}:
      mkNixos system [
        ./configuration.nix
        ./hardware-configuration.nix
        # ./kernel
      ]
  );
}
