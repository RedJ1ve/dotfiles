{
  inputs',
  inputs,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs'.anyrun.packages; [
        applications
        rink
        symbols
        translate
      ];

      width.fraction = 0.25;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 5;
    };
  };
}
