{
  lib,
  pkgs,
  ...
}: {
  programs.xwayland.package = pkgs.xwayland.override (
    final: prev: {
      xwayland = let
        xorgproto = prev.xorg.xorgproto.overrideAttrs (oldAttrs: {patches = oldAttrs.patches ++ [./59.patch];});
        wayland-protocols =
          prev.wayland-protocols.overrideAttrs
          (oldAttrs: {patches = [./90.patch];});
        xwayland' = prev.xwayland.override {inherit xorgproto wayland-protocols;};
      in
        xwayland'.overrideAttrs (oldAttrs: {
          src = prev.fetchurl {
            url = "https://gitlab.freedesktop.org/ekurzinger/xserver/-/archive/explicit-sync/xserver-explicit-sync.tar.gz";
            sha256 = "sha256-Aj+4kuiS48VlpClxGVRBFY/vjnWVMWQMGDwsLnunXYE=";
          };

          depsBuildBuild = oldAttrs.depsBuildBuild ++ [xorgproto wayland-protocols];

          buildInputs = oldAttrs.buildInputs ++ [prev.udev prev.xorg.libpciaccess];

          mesonFlags = lib.lists.remove (lib.mesonBool "xwayland_eglstream" true) oldAttrs.mesonFlags;
        });
    }
  );
}
