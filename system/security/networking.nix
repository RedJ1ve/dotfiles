{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.security;
in {
  options.security.options.networking = mkOption {
    description = "Enable secure networking";
    type = bool;
    default = cfg.enable;
  };

  config = mkIf cfg.options.networking {
    services = {
      tor = {
        enable = true;
        client.enable = true;
      };

      i2pd = {
        enable = true;
        yggdrasil.enable = true;
        proto.httpProxy = {
          enable = true;
          outproxy = "http://false.i2p";
        };
        addressbook.subscriptions = [
          "http://i2p-projekt.i2p/hosts.txt"
          "http://stats.i2p/cgi-bin/newhosts.txt"
          "http://notbob.i2p/hosts.txt"
        ];
      };
      privoxy = {
        enable = true;
        settings = {
          forward = [
            ".i2p 127.0.0.1:4444"
            "200::/7 127.0.0.1:4444"
            ".ygg 127.0.0.1:4444"
          ];
          forward-socks5t = ".onion 127.0.0.1:9050 .";
        };
      };

      networkd-dispatcher.enable = true;
    };

    programs.ssh.startAgent = true;
  };
}
