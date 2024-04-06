{
  inputs,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons

      mplus-outline-fonts.githubRelease

      roboto

      work-sans

      comic-neue

      source-sans

      twemoji-color-font

      comfortaa

      inter

      lato

      lexend

      jost

      dejavu_fonts

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      jetbrains-mono

      maple-mono
      maple-mono-NF
      maple-mono-SC-NF

      inputs.aesthetic-iosevka.packages.${pkgs.system}.default

      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

    enableDefaultPackages = false;

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = ["AestheticIosevka Nerd Font Mono" "Noto Color Emoji"];
        sansSerif = ["AestheticIosevka Nerd Font" "Noto Color Emoji"];
        serif = ["AestheticIosevka Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
