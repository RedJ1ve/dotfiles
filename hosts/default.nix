{
  inputs,
  withSystem,
  sharedModules,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = withSystem "x86_64-linux" ({
    system,
    self',
    inputs',
    ...
  }: let
    systemInputs = {_module.args = {inherit self' inputs';};};
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    desktop = nixosSystem {
      inherit system;

      modules =
        [
          ./desktop
          ../modules/nvidia.nix
          {home-manager.users.aecyr.imports = homeImports."aecyr@desktop";}
          systemInputs
        ]
        ++ sharedModules;
    };
  });
}
