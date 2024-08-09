{
  perSystem = {
    inputs',
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "nix";
      meta.description = "Dev shell for NixosConfiguration";

      DIRENV_LOG_FORMAT = "";

      inputsFrom = [config.treefmt.build.devShell];

      packages = with pkgs; [
        config.treefmt.build.wrapper
        nil
        inputs'.nyxexprs.packages.alejandra-custom
        git
        glow
        statix
        deadnix
        yazi
        micro
      ];
    };
  };
}
