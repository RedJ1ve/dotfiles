{
  config,
  pkgs,
  lib,
  inputs',
  ...
}: let
  inherit (lib) attrValues mkDefault;
in {
  console = let
    variant = "v18n";
  in {
    enable = mkDefault true;
    earlySetup = true;
    keyMap = "uk";

    font = "ter-powerline-${variant}";
    packages = attrValues {inherit (pkgs) terminus_font powerline-fonts;};
  };

  # FIXME: kmscon, in my testing, is working as advertised and a performance difference
  # is observable. However, enabling kmscon seems to *completely* ignore silent boot
  # parameters. Not sure if this is a potential conflict with earlySetup (probably not)
  # or kmscon not respecting the kernel parameters (more likely). Either way, I will
  # revisit this in the future.
  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "AesthetticIosevka Nerd Font Mono";
        package = inputs'.aesthetic-iosevka.packages.default;
      }
    ];

    extraOptions = ''
      --term xterm-256color
      --silent
    '';
    extraConfig = ''
      font-size=14
      xkb-layout=${config.services.xserver.xkb.layout}
    '';
  };
}
