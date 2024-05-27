{
  self,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf optionalString;

  sys = config.modules.system;
  cfg = sys.services;

  # mkSecret is an abstraction over agenix secrets
  # it allows for secrets to be written conditionally and with
  # relatively secure defaults without having to set each one of them
  # manually.
  mkSecret = enableCondition: {
    file,
    owner ? "root",
    group ? "root",
    mode ? "400",
  }:
    mkIf enableCondition {
      file = "${self}/secrets/${file}";
      inherit group owner mode;
    };
in {
  age.identityPaths = [
    "${optionalString sys.impermanence.root.enable "/persist"}/etc/ssh/ssh_host_ed25519_key"
    "${optionalString sys.impermanence.home.enable "/persist"}/home/aecyr/.ssh/id_ed25519"
  ];

  age.secrets = {
    # TODO: system option for declaring host as a potential builder
    #nix-builderKey = mkSecret true {
    #  file = "common/nix-builder.age";
    #};

    #tailscale-client = mkSecret true {
    #  file = "client/tailscale.age";
    #  owner = "aecyr";
    #  group = "users";
    #  mode = "400";
    #};

    #matrix-secret = mkSecret cfg.social.matrix.enable {
    #  file = "service/matrix.age";
    #  owner = "matrix-synapse";
    #  mode = "400";
    #};
  };
}
