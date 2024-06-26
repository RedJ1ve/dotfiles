{lib, ...}: let
  inherit (lib.kernel) yes no;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkForce;
in {
  boot.kernelPatches = [
    {
      # recompile with AMD platform specific optimizations
      name = "amd-platform-patches";
      patch = null; # no patch is needed, just apply the options
      extraStructuredConfig = mapAttrs (_: mkForce) {
        # enable compiler optimizations for INTEL
        MNATIVE_INTEL = yes;

        X86_EXTENDED_PLATFORM = no; # disable support for other x86 platforms

        # multigen LRU
        LRU_GEN = yes;
        LRU_GEN_ENABLED = yes;

        # collect CPU frequency statistics
        CPU_FREQ_STAT = yes;

        # Optimized for performance
        # this is already set on the Xanmod kernel
        # CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;
      };
    }
  ];
}
