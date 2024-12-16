{
  imports = [
    ./gtk.nix
    ./hyprland.nix
  	./matugen.nix
  	./qt.nix
  ];

  dconf.settings = {
  	"org/gnome/desktop/interface" = {
  	  color-scheme = "prefer-dark";
  	};
  };
}
