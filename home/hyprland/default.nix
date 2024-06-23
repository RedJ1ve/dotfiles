{
  inputs',
  config,
  ...
}: {
  imports = [
    # ./binds.nix
    ./binds-hy3.nix
    ./plugins.nix
    ./rules.nix
    ./settings.nix
  ];

  config.wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs'.hyprland.packages.hyprland;

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
