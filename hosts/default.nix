{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  core = ../modules/core;

  hm = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };

    users.aecyr = {
      imports = [../home];
      home.username = "aecyr";
      home.homeDirectory = "/home/aecyr";
    };
  };
in {
  desktop = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      hm
      {inherit home-manager;}

      ./desktop

      core
      nvidia
      wayland

      {networking.hostName = "desktop";}
    ];
    specialArgs = {
      inherit inputs;
      inherit self;
    };
  };
}
