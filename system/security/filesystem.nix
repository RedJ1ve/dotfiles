{
  fileSystems = let
    defaults = ["nodev" "nosuid" "noexec"];
  in {
    "/var/log".options = defaults;
    "/boot".options = defaults;
  };
}
