{
  inputs,
  pkgs,
  ...
}: let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  imports = [
    ./config.nix
    ./binds.nix
    ./rules.nix
  ];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  home.packages = with pkgs;
  with inputs.hyprland-contrib.packages.${pkgs.system}; [
    slurp
    grim
    grimblast
    wl-clip-persist
    wl-clipboard
    cliphist
  ];

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
