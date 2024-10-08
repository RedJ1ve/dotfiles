{pkgs, ...}: {
  home.packages = let
    jdks = with pkgs; [
      temurin-jre-bin

      /* (graalvm-ce.overrideAttrs (_old: rec {
        src = fetchurl {
          url = "https://download.oracle.com/graalvm/22/archive/graalvm-jdk-22_linux-x64_bin.tar.gz";
          sha256 = "1hzk2njd57hn6wxyrznis0sbq33ddwar3j2rn9q0wcc8fmdhp1ni";
        };
      })) */

      (graalvm-ce.overrideAttrs (_old: rec {
        src = fetchurl {
          url = "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-21_linux-x64_bin.tar.gz";
          sha256 = "sha256-vhqzybCLV0e3zVd8mR0ltSFXz/HIxfKQ+FVsWTtXpvQ=";
        };
      }))
    ];

    additionalPrograms = with pkgs; [
      gamemode
      mangohud
    ];

    glfw = pkgs.glfw-wayland-minecraft;
  in [
    (pkgs.prismlauncher.override {
      inherit jdks;

      inherit additionalPrograms;

      inherit glfw;
    })

    pkgs.mangohud
  ];
}
