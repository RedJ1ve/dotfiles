{
  perSystem = {
    inputs',
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "nix";
      meta.description = "Development shell for my NixOS configurations";

      DIRENV_LOG_FORMAT = "";

      inputsFrom = [config.treefmt.build.devShell];

      packages = with pkgs; [
        config.treefmt.build.wrapper
        nil
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
