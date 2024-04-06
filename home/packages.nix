{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
    mangohud
    (prismlauncher-qt5.override {
      jdks = [
        (graalvm-ce.overrideAttrs (old: rec {
          src = fetchurl {
            url = "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-21.0.2_linux-x64_bin.tar.gz";
            sha256 = "1x1qchfyx51p32n668kzi5h1qqvs7q9rm61gvzpzx6k57ivqcqpf";
          };
        }))
        temurin-bin-21
      ];
    })
  ];
}
