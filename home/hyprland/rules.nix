{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = let
      f = regex: "float, ^(${regex})$";
    in [
      (f "org.gnome.Calculator")
      (f "org.gnome.Nautilus")
      (f "pavucontrol")
      (f "nm-connection-editor")
      (f "blueberry.py")
      (f "org.gnome.Settings")
      (f "org.gnome.design.Palette")
      (f "Color Picker")
      (f "xdg-desktop-portal")
      (f "xdg-desktop-portal-gnome")
      (f "transmission-gtk")
      (f "com.github.Aylur.ags")
      "workspace 7, title:Spotify"
    ];

    windowrulev2 = [
      # only allow shadows for floating windows
      "noshadow, floating:0"

      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus,class:foot"
      "idleinhibit fullscreen, class:^(firefox)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
    ];
  };
}
