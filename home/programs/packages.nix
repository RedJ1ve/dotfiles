{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; with gst_all_1;[
    neofetch
    nnn
    tree

    zip
    unzip
    p7zip
    unrar
    file

    steam-run
    p11-kit
    libplist
    sptlrx
    vscode-fhs
    cemu
    krita
    mangohud
    goverlay
    gamemode
    xfce.thunar
    xorg.xlsclients
    obs-studio
    obs-studio-plugins.input-overlay
    sway-contrib.grimshot
    protonup-qt
    winetricks
    lutris
    steam
    steamtinkerlaunch
    temurin-bin-21
    (prismlauncher-qt5.override { jdks = [ (graalvm-ce.overrideAttrs (old: rec { src = fetchurl { url = "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-21.0.2_linux-x64_bin.tar.gz"; sha256 = "1x1qchfyx51p32n668kzi5h1qqvs7q9rm61gvzpzx6k57ivqcqpf";}; })) temurin-bin-21  ]; })
    protontricks
    cava
    librewolf
    ungoogled-chromium
    qbittorrent-nox
    jackett
    duckstation
    docker-compose
    libimobiledevice
    libgcrypt
    libunistring
    libusbmuxd
    nodejs_20
    python311
    python311Packages.pip
    cargo
    rustc
    usbutils
    pciutils
    psmisc
    insomnia

    swww

    dwarfs
    wineWowPackages.stagingFull
    fuse-overlayfs
    bubblewrap
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gst-vaapi
    SDL2_image
 
    fluent-reader

    nur.repos.nltch.spotify-adblock
  ];
}
