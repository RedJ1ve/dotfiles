{lib, ...}: let
  inherit (lib.kernel) yes;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkForce;
in {
  boot.kernelPatches = [
    {
      name = "kernel-lockdown-lsm";
      patch = null;
      extraStructuredConfig = mapAttrs (_: mkForce) {
        SECURITY_LOCKDOWN_LSM = yes;
        LOCKDOWN_LSM_EARLY = yes;
        LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY = yes;

        MODULE_SIG = yes;
        MODULE_SIG_SHA521 = yes;
        MODULE_SIG_FORCE = yes;

        BPF_LSM = yes;
      };
    }
  ];
}
