{inputs', ...}: {
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    package = inputs'.nh.packages.default;
    clean.enable = false;
  };
}
