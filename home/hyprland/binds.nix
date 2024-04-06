{
  config,
  lib,
  pkgs,
  ...
}: let
  binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
  mvfocus = binding "SUPER" "movefocus";
  ws = binding "SUPER" "workspace";
  resizeactive = binding "SUPER CTRL" "resizeactive";
  mvactive = binding "SUPER ALT" "moveactive";
  mvtows = binding "SUPER SHIFT" "movetoworkspace";
  e = "exec, ags -b hypr";
  arr = [1 2 3 4 5 6 7 8 9];

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  wayland.windowManager.hyprland.settings = {
    binds = {
      allow_workspace_cycles = true;
    };

    bind =
      [
        "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
        "SUPER, R,       ${e} -t launcher"
        "SUPER, Tab,     ${e} -t overview"
        ",XF86PowerOff,  ${e} -r 'powermenu.shutdown()'"
        ",XF86Launch4,   ${e} -r 'recorder.start()'"
        ",Print,         ${e} -r 'recorder.screenshot()'"
        "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
        "SUPER, W, exec, schizofox"
        ''SUPER, Q, exec, run-as-service foot${lib.optionalString config.programs.foot.server.enable "client"}''
        "SUPER, C, killactive"

        "CTRL ALT, Delete, exit"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER, G, fakefullscreen"
        "SUPER, P, togglesplit"

        (mvfocus "k" "u")
        (mvfocus "j" "d")
        (mvfocus "l" "r")
        (mvfocus "h" "l")
        (ws "left" "e-1")
        (ws "right" "e+1")
        (mvtows "left" "e-1")
        (mvtows "right" "e+1")
        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")
        (mvactive "k" "0 -20")
        (mvactive "j" "0 20")
        (mvactive "l" "20 0")
        (mvactive "h" "-20 0")
      ]
      ++ (map (i: ws (toString i) (toString i)) arr)
      ++ (map (i: mvtows (toString i) (toString i)) arr);

    bindle = [
      ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
      ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
      ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
      ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
      ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
      ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
    ];

    bindl = [
      ",XF86AudioPlay,    exec, ${playerctl} play-pause"
      ",XF86AudioStop,    exec, ${playerctl} pause"
      ",XF86AudioPause,   exec, ${playerctl} pause"
      ",XF86AudioPrev,    exec, ${playerctl} previous"
      ",XF86AudioNext,    exec, ${playerctl} next"
      ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
    ];

    bindm = [
      "SUPER, mouse:273, resizewindow"
      "SUPER, mouse:272, movewindow"
    ];
  };
}
