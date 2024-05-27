{inputs, ...}: {
  imports = [
    inputs.schizofox.homeManagerModule
  ];

  programs.schizofox = {
    enable = true;
    security = {
      wrapWithProxychains = false;
      sandbox = false;
    };
  };
}
