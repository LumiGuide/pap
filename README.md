Run `nix-build`. On GHC 9.0 this produces:

    pap: internal error: PAP object (0x42000069e8) entered!
        (GHC version 9.0.2 for x86_64_unknown_linux)
        Please report this as a GHC bug:  https://www.haskell.org/ghc/reportabug
        
On GHC 9.2 it just hangs which is expected I think.

This does not prove the bug is resolved in GHC 9.2. Many things affect how the
module is optimized so the test case might be too minimal for GHC 9.2.
