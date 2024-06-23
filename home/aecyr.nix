{
  config = {
    home = {
      username = "aecyr";
      homeDirectory = "/home/aecyr";
      stateVersion = "23.11";
    };

    manual = {
      manpages.enable = false;
      html.enable = false;
      json.enable = false;
    };

    programs.home-manager.enable = true;
  };
}
