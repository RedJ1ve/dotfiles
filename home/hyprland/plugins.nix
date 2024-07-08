{
  inputs',
  config,
  ...
}: {
  config.wayland.windowManager.hyprland = {
    plugins = with inputs'; [
      # hyprspace.packages.Hyprspace
      hyprland-plugins.packages.hyprbars
      hyprland-plugins.packages.csgo-vulkan-fix
    ];

    settings.plugin = {
      csgo-vulkan-fix = {
        res_w = 1280;
        res_h = 800;
        class = "cs2";
      };

      hyprbars = {
        bar_height = 20;
        bar_precedence_over_border = true;

        # order is right-to-left
        hyprbars-button = [
          # close
          "rgb(ff0000), 15, , hyprctl dispatch killactive"
          # maximize
          "rgb(ffff00), 15, , hyprctl dispatch fullscreen 1"
        ];
      };
    };
  };
}
