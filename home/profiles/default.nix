{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = withSystem "x86_64-linux" ({
    inputs',
    self',
    ...
  }: [
    ../.
    module_args
    {_module.args = {inherit inputs' self';};}
    inputs.hyprland.homeManagerModules.default
  ]);

  homeImports = {
    "aecyr@desktop" = [./desktop] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "aecyr@desktop" = homeManagerConfiguration {
        modules = homeImports."aecyr@desktop";
        inherit pkgs;
      };
    });
  };
}
