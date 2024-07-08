{
  inputs',
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = ["AestheticIosevka Nerd Font Mono" "Noto Color Emoji" "Symbols Nerd Font"];
        sansSerif = ["AestheticIosevka Nerd Font" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["AestheticIosevka Nerd Font" "Noto Color Emoji" "Symbols Nerd Font"];
        emoji = ["Noto Color Emoji" "Symbols Nerd Font"];
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    # font packages that should be installed
    packages = with pkgs; [
      # defaults worth keeping
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf # for PDFs, Roman
      unifont
      roboto

      # programming fonts
      sarasa-gothic
      (nerdfonts.override {fonts = ["JetBrainsMono" "NerdFontsSymbolsOnly"];})

      # desktop fonts
      corefonts # MS fonts
      b612 # high legibility
      mplus-outline-fonts.githubRelease
      material-icons # used in widgets and such
      material-design-icons
      work-sans
      comic-neue
      source-sans
      inter
      lato
      lexend
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      jost
      comfortaa

      inputs'.aesthetic-iosevka.packages.default

      maple-mono
      maple-mono-NF
      maple-mono-SC-NF

      # emojis
      noto-fonts-color-emoji
      twemoji-color-font
      openmoji-color
      openmoji-black
    ];
  };
}
