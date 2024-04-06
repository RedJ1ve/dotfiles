{
  inputs,
  config,
  self,
  ...
}: {
  imports = [
    ./ags.nix
    ./dconf.nix
    ./foot.nix
    ./hyprland
    ./packages.nix
    ./scripts
    ./theme.nix
    ./yazi.nix
  ];

  config.home.stateVersion = "23.11";
}
