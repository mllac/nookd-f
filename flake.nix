{
  description = "mellea's nookd flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    proj = pkgs.rustPlatform.buildRustPackage {
      version = "0.1.0";
      pname = "nookd";

      src = builtins.fetchGit {
        rev = "fd3d72f08d2516c2f5681db167d92fc0c22bc335";
        url = "git@github.com:mllac/nookd.git";
        ref = "master";
      };

      cargoLock = {
        lockFile = ./Cargo.lock;
      };

      nativeBuildInputs = with pkgs; [
        pkg-config
      ];

      buildInputs = with pkgs; [
        alsa-lib
        openssl
      ];

      meta = {
        description = "nookd music daemon";
      };
    };

  in {
    packages.${system} = {
      default = proj;
    };
  };
}
