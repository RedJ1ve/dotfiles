{self, ...}: {
  system = {
    stateVersion = "24.05";
    configurationRevision = self.rev or "dirty";
  };
}
