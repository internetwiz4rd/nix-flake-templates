{
  description = "internet_wizard's custom rust development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk/master";
    utils.url = "github:numtide/flake-utils";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    naersk,
    rust-overlay,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import rust-overlay)];
        };
        naersk-lib = pkgs.callPackage naersk {};
        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

        naersk' = pkgs.callPackage naersk {
          cargo = toolchain;
          rustc = toolchain;
          clippy = toolchain;
        };
      in {
        defaultPackage = naersk-lib.buildPackage ./.;
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              cargo
              cargo-info
              rustc
              rustfmt
              clippy
              rust-analyzer
              just

              eza
              fd
              fzf
              bat
            ];
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

            shellHook = ''
              alias ls=eza
              alias find=fd
            '';
          };
      }
    );
}
