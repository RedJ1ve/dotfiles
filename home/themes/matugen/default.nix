{
  lib,
  pkgs,
  inputs,
  inputs',
  config,
  ...
}: let
  transparencyValue = 0.5;
  contrast = 0;
  flavour = "tonal-spot";
in {
  imports = [
    inputs.matugen.homeManagerModules.default

    ./hyprland
    # ./discord
  ];

  programs.matugen = {
    enable = true;
    settings.config = {
      set_wallpaper = true;
      wallpaper_tool = "Swww";

      reload_apps = true;
      reload_apps_list = {
        # gtk_theme = true;
        # dunst = true;
      };

      custom_keywords = {
        transparency = builtins.toString transparencyValue;
        transparency_hex = let
          zeroPad = hex:
            if builtins.stringLength hex == 1
            then "0${hex}"
            else hex;
        in
          zeroPad (lib.trivial.toHexString (builtins.floor (transparencyValue * 255)));
      };
    };
  };

  home.packages = with pkgs; [
    adw-gtk3
    (writeShellApplication {
      name = "theme";
      runtimeInputs = [
        inputs'.matugen.packages.default
        swww
        gnome.zenity
      ];

      text = ''
        WALLPAPER=${config.xdg.configHome}/matugen/wallpaper

         SCHEME=$(dconf read /org/gnome/desktop/interface/color-scheme)
         if [ "$SCHEME" = "'prefer-light'" ]; then
           MODE="light"
         else
           MODE="dark"
         fi

         if [ $# -eq 0 ]; then
           echo -e "\033[1mUsage:\033[0m mode|light|dark|toggle|wallpaper"
           exit 1
         elif [ "$1" = "mode" ]; then
           echo -e "$MODE"
           exit 0
         elif [ "$1" = "wallpaper" ]; then
           if [ $# -eq 1 ]; then
             PICKED=$(zenity --file-selection --file-filter='Images | *.png *.jpg *.jpeg *.svg *.bmp *.gif')
             cp "$PICKED" "$WALLPAPER"
           else
             cp "$2" "$WALLPAPER"
           fi
         elif [ "$1" = "toggle" ]; then
           if [ "$MODE" = "light" ]; then
             MODE="dark"
           else
             MODE="light"
           fi
         elif [ "$1" = "light" ] || [ "$1" = "dark" ]; then
           MODE="$1"
         elif [ "$1" = "init" ]; then
           echo -e "\033[1mSetting up matugen\033[0m"
         else
           echo -e "\033[31mInvalid argument\033[0m"
           exit 1
         fi

         if [ ! -f $WALLPAPER ]; then
           echo -e "\033[31,1mNo wallpaper set\033[0m"
           exit 1
         fi

         if [ "$MODE" = "light" ]; then
           GTK_THEME="adw-gtk3"
         else
           GTK_THEME="adw-gtk3-dark"
         fi

         matugen image "$WALLPAPER" --type scheme-${flavour} --contrast ${builtins.toString contrast} --mode "$MODE"
         dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME'"
         dconf write /org/gnome/desktop/interface/color-scheme "'prefer-$MODE'"

         if command -v hyprctl &> /dev/null; then
           hyprctl reload
         fi
      '';
    })
  ];
}
