{ pkgs ? import <nixpkgs> { } }:

let
  haskellPackages = pkgs.haskell.packages.ghc90;
  ghc = haskellPackages.ghcWithPackages (p: with p; [ async ]);

in pkgs.mkShell {
  buildInputs = [ ghc ];
}
