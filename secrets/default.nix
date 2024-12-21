{inputs, ...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  agenix.secrets = import ./secrets.nix;
}
