{
  config,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      dejavu_fonts
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      hack-font
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "Hack"];})
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Hack"
          "Hack Nerrd Font Complete Mono"
          "Hack Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
