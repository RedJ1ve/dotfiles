{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  prg = sys.programs;

  vesktop-wrapped = (pkgs.vesktop.overrideAttrs (old: {
  	postFixup = ''
  	  wrapProgram $out/bin/vesktop \
  	    --add-flags "--disable-gpu"
  	'';
  }));
in {
  config = mkIf prg.vesktop.enable {
  	home.packages = [
  	  vesktop-wrapped
  	];

  	xdg.configFile."VencordDesktop/VencordDesktop/settings.json".text = builtins.toJSON {
  	  discordBranch = "canary";
  	  firstLaunch = "false";
  	  arRPC = "on";
  	  enableMenu = false;
  	  staticTitle = false;
  	  transparencyOption = "epic banana";
  	};

  	services.arrpc = {
  	  enable = true;
  	  package = pkgs.arrpc.overrideAttrs (_: {
  	    pname = "arrpc";
  	    version = "3.4.0";

  	    src = pkgs.fetchFromGitHub {
  	      owner = "OpenAsar";
  	      repo = "arrpc";
  	      rev = "59553e276716cde3c0afa8bff56aa8af3ab774cc";
  	      hash = "sha256-kjpsPWjgoSNs569DfN8T3/lPB8MzUck7QqD/wfNL8To=";
  	    };
  	  });
  	};
  };
}
