{pkgs, ...}: {
  services = {
    physlock = {
      enable = true;
      allowAnyUser = true;

      lockOn = {
        suspend = false;
        hibernate = false;
      };
    };
    tor = {
      enable = true;
      client.enable = true;
    };
    networkd-dispatcher = {
      enable = true;
      rules."restart-tor" = {
        onState = ["routable" "off"];
        script = ''
          #!${pkgs.runtimeShell}
          if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
            echo "Restarting Tor ..."
            systemctl restart tor
          fi
          exit 0
        '';
      };
    };

    privoxy = {
      enable = true;
      enableTor = true;
    };
  };

  programs.proxychains = {
    enable = true;
    quietMode = false;
    proxyDNS = true;
    package = pkgs.proxychains-ng;
    proxies = {
      tor = {
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };

  programs.ssh.startAgent = true;
}
