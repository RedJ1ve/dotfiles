{pkgs, ...}: {
  home.packages = [
    (pkgs.prismlauncher.override {
      jdks = with pkgs; [
        temurin-jre-bin
        temurin-jre-bin-21

        # Java 22
        (graalvm-ce.overrideAttrs (_old: rec {
          src = fetchurl {
            url = "https://download.oracle.com/graalvm/22/archive/graalvm-jdk-22_linux-x64_bin.tar.gz";
            sha256 = "1hzk2njd57hn6wxyrznis0sbq33ddwar3j2rn9q0wcc8fmdhp1ni";
          };
        }))

        # Java 21
        /*(graalvm-ce.overrideAttrs (_old: rec {
          src = fetchurl {
            url = "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-21_linux-x64_bin.tar.gz";
            sha256 = "sha256-vhqzybCLV0e3zVd8mR0ltSFXz/HIxfKQ+FVsWTtXpvQ=";
          };
        })) */
      ];

      additionalPrograms = with pkgs; [
        gamemode
        mangohud
        gamescope
        glfw
        glfw-wayland-minecraft
      ];
    })
    
    pkgs.mangohud
  ];
}
