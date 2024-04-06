{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${lib.optionalString config.programs.foot.server.enable ''run-as-service 'foot --server''}"
        "ags -b hypr"
        "hyprctl setcursor Qogir 24"
      ];

      monitor = [
        ",preferred,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        sensitivity = 0.0;
        float_switch_override_focus = 2;
        touchpad = {
          clickfinger_behavior = true;
          tap-to-click = false;
          scroll_factor = 0.5;
        };
      };

      general = {
        layout = "dwindle";
        resize_on_border = true;
        no_cursor_warps = true;
      };

      misc = {
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;

        vfr = true;

        enable_swallow = true;
        swallow_regex = "^(foot)$";

        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      animations = {
        enabled = true;
        first_launch_animation = false;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border,1,10,default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces,1,4,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = "yes";
        no_gaps_when_only = false;
      };
    };
  };
}
