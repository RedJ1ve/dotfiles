{
  withSystem,
  self,
  inputs,
  ...
}: let
  extendedLib = inputs.nixpkgs.lib.extend (final: prev: {
    mkSystem = {
      system,
      hostname,
      ...
    } @ args:
      withSystem system ({
        self',
        inputs',
        ...
      }:
        prev.nixosSystem {
          system = system;

          specialArgs = {inherit self inputs self' inputs';};

          modules =
            [
              {networking.hostName = hostname;}
            ]
            ++ (args.modules or []);
        });
  });
in {
  perSystem._module.args.lib = extendedLib;
  flake.lib = extendedLib;
}
