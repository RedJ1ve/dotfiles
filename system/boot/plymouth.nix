{pkgs, ...}: let
  selectedTheme = "rings";
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
