{
  inputs',
  inputs,
  ...
}: {
  home-manager = {
    verbose = true;
    backupFileExtension = "hm.old";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs' inputs;};

    users.aecyr.imports = [
      ./aecyr.nix

      ./programs
      ./hyprland
      # ./themes
    ];
  };
}
