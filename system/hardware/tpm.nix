{pkgs, ...}: {
  boot.kernelModules = ["uhid"];

  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
    abrmd.enable = true;
    tctiEnvironment.enable = true;
    pkcs11.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tpm2-tools
    tpm2-tss
    tpm2-abrmd
  ];
}
