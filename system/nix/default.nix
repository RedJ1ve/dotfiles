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
  ];

  environment = {
    systemPackages = with pkgs; [git];
    defaultPackages = [];
  };

  nix = {
    package = pkgs.nixVersions.git;

    # using nh builtin gc
    gc.automatic = false;

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

      # execute builds inside cgroups
      use-cgroups = true;

      # force nix to use the xdg directory specification
      use-xdg-base-directories = true;

      # disable dirty git tree warning
      warn-dirty = false;

      # set of features supported by the system
      system-features = ["nixos-test" "benchmark" "big-parallel" "kvm" "recursive-nix"];

      # features that arent enabled by default
      extra-experimental-features = [
        "auto-allocate-uids" # allows nix to automatically pick UIDs for builds, rather than creating nixbld* user accounts
        "ca-derivations" # allow derivations to be content-adressed
        "cgroups" # allows nix to execute builds inside cgroups
        "flakes" # enables flakes
        "nix-command" # enable the new nix subcommands
        "recursive-nix" # allow derivation builders to call nix, and thus build derivations recursively
      ];

      # substituters to use
      substituters = [
        "https://cache.ngi0.nixos.org" # content addressed nix cache (TODO)
        "https://cache.nixos.org" # funny binary cache
        "https://cache.privatevoid.net" # for nix-super
        "https://nixpkgs-wayland.cachix.org" # automated builds of *some* wayland packages
        "https://nix-community.cachix.org" # nix-community cache
        "https://hyprland.cachix.org" # hyprland
        "https://nixpkgs-unfree.cachix.org" # unfree-package cache
        "https://numtide.cachix.org" # another unfree package cache
        "https://anyrun.cachix.org" # anyrun program launcher
        "https://nyx.cachix.org" # cached stuff from my flake outputs
        "https://neovim-flake.cachix.org" # a cache for my neovim flake
        "https://cache.garnix.io" # garnix binary cache, hosts prismlauncher
        "https://cache.notashelf.dev" # my own binary cache, served over https
        "https://ags.cachix.org" # ags
      ];

      # substituter keys
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
        "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "notashelf.cachix.org-1:VTTBFNQWbfyLuRzgm2I7AWSDJdqAa11ytLXHBhrprZk="
        "neovim-flake.cachix.org-1:iyQ6lHFhnB5UkVpxhQqLJbneWBTzM8LBYOFPLNH4qZw="
        "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.notashelf.dev-1:DhlmJBtURj+XS3j4F8SFFukT8dYgSjtFcd3egH8rE6U="
        "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
      ];
    };
  };
}
