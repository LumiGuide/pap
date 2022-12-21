{ mkDerivation, async, base, lib }:
mkDerivation {
  pname = "pap";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ async base ];
  license = "unknown";
  mainProgram = "pap";
}
