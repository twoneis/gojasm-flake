{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { inherit system; }; 
      in {
        packages = rec {
          gojasm = pkgs.callPackage ./gojasm.nix { };
          default = gojasm;
        };
        overlay = (self: super: {
          gojasm = super.callPackage ./gojasm.nix { };
        });
      }
    );
}
