{
  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        {config._module.args._inputs = inputs // {inherit (inputs) self;};}

        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        inputs',
        config,
        pkgs,
        ...
      }: {
        packages = {
          asztal = pkgs.callPackage ./ags {inherit inputs;};
        };

        formatter = pkgs.alejandra;

        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            black.enable = true;
            deadnix.enable = true;
            shellcheck.enable = true;
            shfmt = {
              enable = true;
              indent_size = 4;
            };
          };
        };
      };

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    matugen.url = "github:InioX/Matugen";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    aesthetic-iosevka.url = "github:alphatechnolog/aesthetic-iosevka";

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        nixpak.follows = "nixpak";
      };
    };

    schizosearch = {
      url = "github:sioodmy/schizosearch";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
}
