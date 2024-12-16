{
  self',
  inputs',
  self,
  inputs,
  ...
}: {
  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit self' inputs' self inputs;};
    backupFileExtension = "hm.old";

    users.aecyr.imports = [
      ./aecyr.nix

      ./ags
      ./programs
      ./services
      ./hyprland
      ./theme
    ];

    sharedModules = [
      {
        programs.home-manager.enable = true;

        manual = {
          manpages.enable = false;
          html.enable = false;
          json.enable = false;
        };
      }
    ];
  };
}
