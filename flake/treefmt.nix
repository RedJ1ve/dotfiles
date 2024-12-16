{inputs, ...}: {
  imports = [
    inputs.treefmt.flakeModule
  ];

  perSystem = {
    inputs',
    config,
    pkgs,
    ...
  }: {
    formatter = config.treefmt.build.wrapper;

    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        alejandra = {
          enable = true;
          package = inputs'.nyxexprs.packages.alejandra-custom;
        };

        shellcheck.enable = true;

        prettier = {
          enable = true;
          package = pkgs.prettierd;
          excludes = ["*.age"];
          settings.editorconfig = true;
        };

        shfmt = {
          enable = true;
          indent_size = 2;
        };
      };
    };
  };
}
