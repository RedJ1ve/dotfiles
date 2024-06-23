let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, hy3:movetoworkspace, ${toString (x + 1)}"
        "$mod CONTROL, ${ws}, hy3:focustab, index, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binds
    bind = let
      monocle = "dwindle:no_gaps_when_only";
    in
      [
        # compositor commands
        "CONTROL ALT, Delete, exec, pkill Hyprland"
        "$mod, C, hy3:killactive,"
        "$mod, F, fullscreen,"
        "$mod, T, togglesplit,"
        "$mod SHIFT, F, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # toggle workspace overview
        # "$mod, Tab, overview:toggle"

        # open application launcher
        "$mod, R, exec, pkill fuzzel || run-as-service fuzzel"

        # utility
        # terminal
        "$mod, Q, exec, run-as-service foot"
        "$mod SHIFT, Q, exec, [floating] run-as-service foot"
        # logout menu
        "$mod, Escape, exec, wlogout -p layer-shell"
        # lock screen
        "$mod, L, exec, loginctl lock-session"
        # select area to perform OCR on
        "$mod, O, exec, run-as-service wl-ocr"
        ", XF86Favorites, exec, run-as-service wl-ocr"
        # open calculator
        ", XF86Calculator, exec, run-as-service gnome-calculator"

        "$mod, D, hy3:makegroup, h"
        "$mod, S, hy3:makegroup, v"
        "$mod, Z, hy3:makegroup, tab"
        "$mod, A, hy3:changefocus, raise"
        "$mod SHIFT, A, hy3:changefocus, lower"
        "$mod, E, hy3:expand, expand"
        "$mod SHIFT, E, hy3:expand, base"
        "$mod, R, hy3:changegroup, opposite"

        "$mod, H, hy3:movefocus, l"
        "$mod, J, hy3:movefocus, d"
        "$mod, K, hy3:movefocus, u"
        "$mod, L, hy3:movefocus, r"
        "$mod, left, hy3:movefocus, l"
        "$mod, down, hy3:movefocus, d"
        "$mod, up, hy3:movefocus, u"
        "$mod, right, hy3:movefocus, r"

        "$mod CONTROL, H, hy3:movefocus, l, visible, nowarp"
        "$mod CONTROL, J, hy3:movefocus, d, visible, nowarp"
        "$mod CONTROL, K, hy3:movefocus, u, visible, nowarp"
        "$mod CONTROL, L, hy3:movefocus, r, visible, nowarp"
        "$mod CONTROL, left, hy3:movefocus, l, visible, nowarp"
        "$mod CONTROL, down, hy3:movefocus, d, visible, nowarp"
        "$mod CONTROL, up, hy3:movefocus, u, visible, nowarp"
        "$mod CONTROL, right, hy3:movefocus, r, visible, nowarp"

        "$mod SHIFT, H, hy3:movewindow, l, once"
        "$mod SHIFT, J, hy3:movewindow, d, once"
        "$mod SHIFT, K, hy3:movewindow, u, once"
        "$mod SHIFT, L, hy3:movewindow, r, once"
        "$mod SHIFT, left, hy3:movewindow, l, once"
        "$mod SHIFT, down, hy3:movewindow, d, once"
        "$mod SHIFT, up, hy3:movewindow, u, once"
        "$mod SHIFT, right, hy3:movewindow, r, once"

        "$mod CONTROL SHIFT, H, hy3:movewindow, l, once, visible"
        "$mod CONTROL SHIFT, J, hy3:movewindow, d, once, visible"
        "$mod CONTROL SHIFT, K, hy3:movewindow, u, once, visible"
        "$mod CONTROL SHIFT, L, hy3:movewindow, r, once, visible"
        "$mod CONTROL SHIFT, left, hy3:movewindow, l, once, visible"
        "$mod CONTROL SHIFT, down, hy3:movewindow, d, once, visible"
        "$mod CONTROL SHIFT, up, hy3:movewindow, u, once, visible"
        "$mod CONTROL SHIFT, right, hy3:movewindow, r, once, visible"

        # screenshot
        # area
        ", Print, exec, grimblast --notify copysave area"

        # current screen
        "CTRL, Print, exec, grimblast --notify --cursor copysave output"

        # all screens
        "CTRL SHIFT, Print, exec, grimblast --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, eDP-1"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod CONTROL SHIFT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod CONTROL SHIFT, bracketright, movecurrentworkspacetomonitor, r"
      ]
      ++ workspaces;

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
