{...}: {
  imports = [
    ./hosts.nix
    ./treefmt.nix
    ./devshell.nix
  ];

  systems = ["x86_64-linux"];
}
