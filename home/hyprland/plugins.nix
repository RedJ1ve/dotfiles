{
  inputs',
  config,
  ...
}: {
  config.wayland.windowManager.hyprland = {
    /* plugins = with inputs'; [
      # hyprspace.packages.Hyprspace
      hyprland-plugins.packages.csgo-vulkan-fix
    ]; */

    settings.plugin = {
      csgo-vulkan-fix = {
        res_w = 1280;
        res_h = 800;
        class = "cs2";
      };
    };
  };
}
