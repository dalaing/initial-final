{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  haskellPackages = 
    if compiler == "default"
    then pkgs.haskellPackages
    else pkgs.haskell.packages.${compiler};

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: {
      initial = self.callPackage ../initial/initial.nix {};
      final = self.callPackage ../final/final.nix {};
      initial-bp = pkgs.haskell.lib.dontHaddock (self.callPackage ../initial-bp/initial-bp.nix {});
      final-bp = pkgs.haskell.lib.dontHaddock (self.callPackage ../final-bp/final-bp.nix {});
    };
  };

  drv = modifiedHaskellPackages.callPackage ./bench.nix {};

in

  drv