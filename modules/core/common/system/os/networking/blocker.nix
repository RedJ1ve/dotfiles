{config, ...}: let
  dev = config.modules.device;
in {
  # this should block *most* junk sites
  networking = {
    stevenblack = {
      enable = true; # don't touch hosts file on a server
      block = [
        "fakenews"
        "gambling"
        "porn"
        #"social" # blocks stuff like reddit, which I occasionally visit
      ];
    };
  };
}
