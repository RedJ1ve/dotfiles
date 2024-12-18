{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;

  cfg = config.boot.plymouth;
in {
  config = { #mkIf cfg.enable {
    boot.plymouth = {
      theme = mkDefault "dark_planet";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [cfg.theme];
        })
      ];
    };
  };
}
