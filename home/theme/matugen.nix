{
  inputs',
  pkgs,
  ...
}: let
  set-gnome-theme = pkgs.writeShellScriptBin "set-gnome-theme" ''
    XDG_DATA_DIRS='${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}' gsettings set org.gnome.desktop.interface gtk-theme ""
     XDG_DATA_DIRS='${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}' gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
  '';
in {
  home.packages = with pkgs; [
    inputs'.matugen.packages.default
    swww
    set-gnome-theme
  ];

  xdg.configFile."matugen/config.toml".source = (pkgs.formats.toml {}).generate "matugen" {
    config = {
      wallpaper = {
        command = "swww";
        arguments = ["img" "--transition-type" "center"];
        set = true;
      };
    };

    templates = {
      hyprland = {
        input_path = ./templates/hyprland.conf;
        output_path = "~/.config/hypr/colors.conf";
        post_hook = "hyprctl reload";
      };
      gtk4 = {
        input_path = ./templates/gtk.css;
        output_path = "~/.config/gtk-4.0/theme.css";
        post_hook = "${set-gnome-theme}/bin/set-gnome-theme";
      };

      gtk3 = {
        input_path = ./templates/gtk.css;
        output_path = "~/.config/gtk-3.0/theme.css";
        post_hook = "${set-gnome-theme}/bin/set-gnome-theme";
      };
      qt5ct = {
        input_path = ./templates/qt.conf;
        output_path = "~/.config/qt5ct/colors/matugen.conf";
      };
      qt6ct = {
        input_path = ./templates/qt.conf;
        output_path = "~/.config/qt6ct/colors/matugen.conf";
      };
    };
  };
}
