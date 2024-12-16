{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.boot.plymouth;
in {
  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      theme = lib.mkDefault "dark_planet";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [cfg.theme];
        })
      ];
    };
  };
}
