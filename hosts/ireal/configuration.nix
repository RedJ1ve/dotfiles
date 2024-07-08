{pkgs, ...}: {
  networking.hostName = "ireal"; # Define your hostname.

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  users.users.aecyr = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
