{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  imports = [
    ./gaming.nix
  ];

  options.modules.system.programs = {
    gui.enable = mkEnableOption "GUI package sets" // {default = true;};
    cli.enable = mkEnableOption "CLI package sets" // {default = true;};
    dev.enable = mkEnableOption "development related package sets";

    libreoffice.enable = mkEnableOption "LibreOffice suite";
    element.enable = mkEnableOption "Element Matrix client";
    obs.enable = mkEnableOption "OBS Studio";
    spotify.enable = mkEnableOption "Spotify music player";
    thunderbird.enable = mkEnableOption "Thunderbird mail client";
    vscode.enable = mkEnableOption "Visual Studio Code";
    steam.enable = mkEnableOption "Steam game client";
    kdeconnect.enable = mkEnableOption "KDE Connect utility";
    vesktop.enable = mkEnableOption "Vencord Discord client";
    zathura.enable = mkEnableOption "Zathura document viewer";
    rnnoise.enable = mkEnableOption "RNNoise noise suppression plugin";
    noisetorch.enable = mkEnableOption "NoiseTorch noise suppression plugin";

    firefox = {
      enable = mkEnableOption "Firefox browser";
      schizofox.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Schizofox Firefox Tweaks";
      };
    };

    editors = {
      neovim.enable = mkEnableOption "Neovim text editor";
      helix.enable = mkEnableOption "Helix text editor";
      micro.enable = true;
    };

    terminals = {
      kitty.enable = mkEnableOption "Kitty terminal emulator";
      wezterm.enable = mkEnableOption "WezTerm terminal emulator";
      foot.enable = mkEnableOption "Foot terminal emulator";
    };

    git = {
      signingKey = mkOption {
        type = types.str;
        default = "";
        description = "The default gpg key used for signing commits";
      };
    };

    # default program options
    default = {
      # what program should be used as the default terminal
      terminal = mkOption {
        type = types.enum ["foot" "kitty" "wezterm"];
        default = "foot";
      };

      fileManager = mkOption {
        type = types.enum ["thunar" "dolphin" "nemo"];
        default = "thunar";
      };

      browser = mkOption {
        type = types.enum ["firefox" "librewolf"];
        default = "firefox";
      };

      editor = mkOption {
        type = types.enum ["micro" "neovim" "helix" "emacs"];
        default = "micro";
      };

      launcher = mkOption {
        type = types.enum ["anyrun"];
        default = "anyrun";
      };
    };
  };
}
