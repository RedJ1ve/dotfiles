{
  pkgs,
  ...
}: {
  config.programs.fuzzel = {
  	enable = true;
  	settings = {
  	  main = {
  	  	terminal = "${pkgs.foot}/bin/foot";
  	  	lines = 10;
  	  };

  	  colors = {
  	  	background = "1e1e2eaa";
  	  	text = "cdd6f4ff";
  	  	match = "f38ba8ff";
  	  	selection = "585b70ff";
  	  	selection-match = "f38ba8ff";
  	  	selection-text = "cdd6f4ff";
  	  	border = "b4befeff";
  	  };

  	  border = {
  	  	radius = 20;
  	  	width = 3;
  	  };
  	};
  };
}
