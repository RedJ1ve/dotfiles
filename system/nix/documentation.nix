{
  # disabling unneeded documentation
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;

    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
