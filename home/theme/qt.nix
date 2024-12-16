{
  qt = {
  	enable = true;
  	platformTheme.name = "qtct";
  };

  xdg.configFile = {
  	"qt5ct.qt5ct.conf".text = ''
  	  [Appearance]
  	  color_scheme_path=~/.config/qt5ct/colors/matugen.conf
  	  custom_palette=true
  	'';

  	"qt6ct.qt6ct.conf".text = ''
  	  [Appearance]
  	  color_scheme_path=~/.config/qt6ct/colors/matugen.conf
  	  custom_palette=true
  	'';
  };
}
