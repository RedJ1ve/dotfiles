{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.modules.system.virtualization = {
    enable = mkEnableOption "virtualization";
    libvirt = {enable = mkEnableOption "libvirt";};
    qemu = {enable = mkEnableOption "qemu";};
    waydroid = {enable = mkEnableOption "waydroid";};
    distrobox = {enable = mkEnableOption "distrobox";};
  };
}
