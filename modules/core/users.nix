{
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;

  users = {
    users = {
      aecyr = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
        uid = 1000;
        shell =
          if config.services.greetd.enable
          then pkgs.zsh
          else pkgs.bash;
      };
    };
  };
}
