{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.graphical;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      lowLatency.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    hardware.pulseaudio.enable = lib.mkForce false;
  };
}
