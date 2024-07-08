{config, ...}: {
  config.environment = {
    etc."greetd/environments".text = ''
      Hyprland
      zsh
    '';

    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11";
      ANKI_WAYLAND = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
  };
}
