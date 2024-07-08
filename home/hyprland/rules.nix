{...}: {
  wayland.windowManager.hyprland.settings = {
    # window rules
    windowrulev2 = [
      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "size 360 490, class:^(org.gnome.Calculator)$"

      # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

      # don't render hyprbars on tiling windows
      "plugin:hyprbars:nobar, floating:0"
    ];
  };
}
