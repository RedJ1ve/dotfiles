{inputs', ...}: {
  environment.systemPackages = with inputs'; [
    nixvim.packages.default
  ];
}
