{pkgs, ...}: {
  config.environment.systemPackages = [
    pkgs.heroic
  ];
}
