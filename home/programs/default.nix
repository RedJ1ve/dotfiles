{
  self',
  inputs',
  pkgs,
  ...
}: {
  imports = [
    ./ani-cli.nix
    ./anyrun.nix
    ./dconf.nix
    ./discord.nix
    ./foot.nix
    # ./lutris.nix
    ./minecraft.nix
    ./mpv.nix
    ./run-as-service.nix
    ./schizofox.nix
  ];

  home.packages = with pkgs; [
    self'.packages.wl-ocr

    unrar
    p7zip

    lutris
    wineWowPackages.stagingFull
    rpcs3
    inputs'.umu.packages.umu

    jupyter

    winetricks
    protontricks

    thunderbird
    libreoffice-qt
    nautilus
    telegram-desktop
    beeper

    obsidian
    keepassxc
    # calcure
  ];
}
