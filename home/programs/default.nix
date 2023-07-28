{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../terminals/foot.nix
    ./packages.nix
    ./firefox
  ];
}
