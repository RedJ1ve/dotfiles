{pkgs, ...}: let
  selectedTheme = "dark_planet";
in {
  boot.plymouth = {
    enable = true;
    theme = selectedTheme;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [selectedTheme];
      })
    ];
  };
}
