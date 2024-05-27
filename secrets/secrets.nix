let
  keys = import ../flake/keys.nix;
  inherit (keys) servers workstations;
  inherit (keys) mkGlobal;
in {
  # core system secrets
  # "common/nix-builder.age".publicKeys = mkGlobal (workstations ++ servers);
  # "client/tailscale.age".publicKeys = mkGlobal (workstations ++ servers);

  # service specific secrets
  # "service/matrix.age".publicKeys = mkGlobal servers;
}
