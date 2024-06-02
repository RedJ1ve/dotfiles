{
  config = {
  
    boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/-efdd710-7b66-476d-bdee-341a3f29b5be";


    fileSystems."/" = {
      device = "/dev/disk/by-uuid/edec9184-5d4a-40ed-9b9f-f84d86319533";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/edec9184-5d4a-40ed-9b9f-f84d86319533";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd" "noatime"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/edec9184-5d4a-40ed-9b9f-f84d86319533";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/edec9184-5d4a-40ed-9b9f-f84d86319533";
      fsType = "btrfs";
      options = ["subvol=persist" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-uuid/edec9184-5d4a-40ed-9b9f-f84d86319533";
      fsType = "btrfs";
      options = ["subvol=log" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/9755-2473";
      fsType = "vfat";
      options = ["umask=0077"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/521de58a-c37c-4383-8d7f-4d981d0048ea";}
    ];
  };
}
