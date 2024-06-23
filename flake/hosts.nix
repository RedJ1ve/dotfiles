{
  withSystem,
  inputs,
  ...
}: {
  imports = [../hosts];

  _module.args.mkNixos = system: extraModules: let
    specialArgs =
      withSystem system ({inputs', ...}: {inherit inputs' inputs;});
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;

      modules =
        [
          inputs.home-manager.nixosModules.home-manager

          ../home
          ../system
        ]
        ++ extraModules;
    };
}
