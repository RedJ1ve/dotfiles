{ inputs', pkgs, ... }: {
  home.packages = with pkgs; [
    adw-gtk3
    glib
  ];

  gtk = {
  	enable = true;
    theme = {
   	  name = "adw-gtk3-dark";
   	  package = pkgs.adw-gtk3;
   	};  	
  	gtk3.extraCss = # css
  	  "@import './theme.css';";
  	gtk4.extraCss = # css
  	  "@import './theme.css';";
  };
}
