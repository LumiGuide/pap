{ pkgs ? import <nixpkgs> { } }:

let
  haskellPackages = pkgs.haskell.packages.ghc90;
  pap = haskellPackages.callPackage ./package.nix { };

in pkgs.runCommand "run-pap" { } ''
  ${pap}/bin/pap
''
