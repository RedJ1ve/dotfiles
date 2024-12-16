{
  withSystem,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) lib;
    inherit (lib) mkSystem;

    home-manager = [
      inputs.home-manager.nixosModules.home-manager
      ../home
    ];
  in {
    legion = mkSystem {
      hostname = "legion";
      system = "x86_64-linux";
      modules =
        [
          ./legion
          ../system
        ]
        ++ home-manager;
    };
  };
}
