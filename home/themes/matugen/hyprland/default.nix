{config, pkgs, ...}: {
  programs.matugen.settings.templates.hyprland = {
  	input_path = ./theme.conf;
    output_path = "${config.xdg.configHome}/hypr/theme.conf";
  };

  wayland.windowManager.hyprland = {
    settings.exec-once = [
      "${pkgs.swww}/bin/swww-daemon"
      "theme init"
    ];
    extraConfig = ''
      source=./theme.conf
    '';
  };
}
