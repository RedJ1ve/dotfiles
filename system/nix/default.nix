{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./documentation.nix
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  environment = {
    systemPackages = with pkgs; [git];
    defaultPackages = [];
  };

  nix = {
    package = pkgs.lix;

    gc.automatic = true;

    # automatically optimise the nix store
    optimise.automatic = true;

    # set the nix builder to a low priority
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # automatically optimise the nix store
      auto-optimise-store = true;

      # allow sudo users to manage nix store
      allowed-users = ["root" "@wheel"];
      trusted-users = ["root" "@wheel"];

      # use binary cache, this is not gentoo
      builders-use-substitutes = true;

      # move on if package cannot be found in cache
      connect-timeout = 5;

      flake-registry = "/etc/nix/registry.json";

      # allow unlimited tcp connections
      http-connections = 0;

      # continue building after a failiure
      keep-going = true;

      # nix decides the maximim number of jobs
      max-jobs = "auto";

      # nix builder runs in sandboxed enrironments
      sandbox = true;
      sandbox-fallback = false;

      # force nix to use the xdg directory specification
      use-xdg-base-directories = true;

      # disable dirty git tree warning
      warn-dirty = false;

      # set of features supported by the system
      system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"];

      # features that arent enabled by default
      extra-experimental-features = [
        "auto-allocate-uids" # allows nix to automatically pick UIDs for builds, rather than creating nixbld* user accounts
        "flakes" # enables flakes
        "nix-command" # enable the new nix subcommands
      ];
    };
  };
}
