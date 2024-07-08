{inputs, ...}: {
  imports = [inputs.schizofox.homeManagerModule];

  programs.schizofox = {
    enable = true;
    security = {
      sandbox = false;
      wrapWithProxychains = false;
    };
  };
}
