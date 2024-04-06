{...}: {
  imports = [
    ./bootloader.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./schizo.nix
    ./system.nix
    ./users.nix
  ];
}
