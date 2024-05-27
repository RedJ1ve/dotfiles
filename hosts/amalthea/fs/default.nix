{
  config = {
  
    boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/08380e58-57d0-43d6-aebb-d5bf9ec98834";


    fileSystems."/" = {
      device = "/dev/disk/by-uuid/752615a1-bfdf-4451-b609-76fed6f7fce9";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/752615a1-bfdf-4451-b609-76fed6f7fce9";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd" "noatime"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/752615a1-bfdf-4451-b609-76fed6f7fce9";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/752615a1-bfdf-4451-b609-76fed6f7fce9";
      fsType = "btrfs";
      options = ["subvol=persist" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

    fileSystems."/var/log" = {
      device = "/dev/disk/by-uuid/752615a1-bfdf-4451-b609-76fed6f7fce9";
      fsType = "btrfs";
      options = ["subvol=log" "compress=zstd" "noatime"];
      neededForBoot = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/70D4-EEB2";
      fsType = "vfat";
      options = ["umask=0077"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/943ed154-e391-4c63-ac22-40887c73a460";}
    ];
  };
}
