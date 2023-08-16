{
  self,
  inputs,
  default,
  ...
}: let
  module_args._module.args = {
    inherit default inputs self;
  };
in {
  imports = [
    {
      _module.args = {
        inherit module_args;

        sharedModules = [
          {home-manager.useGlobalPkgs = true;}
          inputs.home-manager.nixosModule
          inputs.hyprland.nixosModules.default
          inputs.nur.nixosModules.nur
          module_args
          ./bootloader.nix
          ./core.nix
          ./fonts.nix
          ./nix.nix
          ./security.nix
          ./services.nix
        ];
      };
    }
  ];

  flake.nixosModules = {
    bootloader = import ./bootloader.nix;
    core = import ./core.nix;
    fonts = import ./fonts.nix;
    nix = import ./nix.nix;
    nvidia = import ./nvidia.nix;
    security = import ./security.nix;
    services = import ./services.nix;
  };
}
