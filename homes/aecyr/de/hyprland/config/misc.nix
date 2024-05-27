{
  wayland.windowManager.hyprland.settings = {
    misc = {
      # disable redundant renders
      disable_hyprland_logo = true; # wallpaper covers it anyway
      disable_splash_rendering = true; # "

      # window swallowing
      enable_swallow = true; # hide windows that spawn other windows
      swallow_regex = "foot|nautilus"; # windows for which swallow is applied

      # dpms
      mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
      key_press_enables_dpms = true; # enable dpms on keyboard action
    };
  };
}
