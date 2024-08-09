{
  description = "A flake for the pg-trunk Cargo package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system rust-overlay;
          };
        in
	{
          packages = with pkgs; {
            default = rustPlatform.buildRustPackage rec {
              pname = "pg-trunk";
              version = "0.12.26";

              sourceRoot = "${src.name}/cli";
	      #cargoRoot = "${src}/cli";
            
              src = fetchFromGitHub {
                owner = "tembo-io";
                repo = "trunk";
                rev = "14a80ba";
                hash = "sha256-z5ppkE9ZDZ2rKvVNzpu6akWAfpImVDPEhcJTbzAUXSw=";
              };
            
              cargoHash = "sha256-T+RcZAAkervLSVC5Wf/hhEzoGyAsrL2bdS4wfbemEKI=";
            
              meta = with lib; {
                description = "postgres package manager";
                homepage = "https://github.com/tembo-io/trunk";
                license = licenses.postgresql;
                maintainers = [];
              };
            };
          };
        });
}
