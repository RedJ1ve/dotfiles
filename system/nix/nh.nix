{inputs', ...}: {
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    package = inputs'.nh.packages.default;

    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };
}
