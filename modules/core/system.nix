{
  pkgs,
  lib,
  ...
}: {
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
    dconf.enable = true;
  };

  environment.variables = {
    EDITOR = "micro";
    BROWSER = "schizofox";
  };
  environment.systemPackages = with pkgs; [
    git
    btrfs-progs
    starship
  ];

  time = {
    timeZone = "Europe/London";
    hardwareClockInLocalTime = true;
  };
  hardware.ledger.enable = true;

  i18n = let
    defaultLocale = "en_US.UTF-8";
    gb = "en_GB.UTF-8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = gb;
      LC_IDENTIFICATION = gb;
      LC_MEASUREMENT = gb;
      LC_MONETARY = gb;
      LC_NAME = gb;
      LC_NUMERIC = gb;
      LC_PAPER = gb;
      LC_TELEPHONE = gb;
      LC_TIME = gb;
    };
  };
  console = let
    variant = "u24n";
  in {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
    earlySetup = true;
    keyMap = "uk";
  };

  programs.nix-ld.enable = true;
  systemd.oomd.enableRootSlice = true;
}
