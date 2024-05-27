{
  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule

        ./flake/lib
        ./flake/modules
        ./flake/pkgs
        ./flake/pre-commit

        ./flake/args.nix
        ./flake/fmt.nix
        ./flake/shell.nix
      ];

      flake = {
        nixosConfigurations = import ./hosts {inherit inputs withSystem;};
      };
    });

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:Nixos/nixpkgs/nixos-unstable-small";
    nix-super.url = "github:privatevoid-net/nix-super";
    nyxpkgs.url = "github:NotAShelf/nyxpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    nixfmt = {
      url = "github:nixos/nixfmt";
      flake = false;
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-compat.follows = "flake-compat";
      };
    };

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-parts.follows = "flake-parts";
      };
    };

    impermanence.url = "github:nix-community/impermanence";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        home-manager.follows = "home-manager";
        darwin.follows = "";
      };
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-utils.follows = "flake-utils";
      };
    };

    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        rust-overlay.follows = "rust-overlay";
      };
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    neovim-flake = {
      url = "github:NotAShelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        nil.follows = "nil";
        flake-utils.follows = "flake-utils";
        flake-parts.follows = "flake-parts";
      };
    };

    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    matugen.url = "github:InioX/matugen";

    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-parts.follows = "flake-parts";
        nixpak.follows = "nixpak";
      };
    };

    aesthetic-iosevka.url = "github:alphatechnolog/aesthetic-iosevka";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.privatevoid.net"
      "https://nyx.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
      "notashelf.cachix.org-1:VTTBFNQWbfyLuRzgm2I7AWSDJdqAa11ytLXHBhrprZk="
      "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
    ];
  };
}
