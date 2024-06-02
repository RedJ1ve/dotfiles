{self, ...}: {
  system = {
    stateVersion = "23.11";
    configurationRevision = self.rev or "dirty";
  };
}
