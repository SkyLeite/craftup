{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # specify which packages to add to the shell environment
  packages = [
    pkgs.elixir_1_11
    pkgs.elixir_ls
    pkgs.rustc
    pkgs.cargo
    pkgs.cargo-make
    pkgs.cargo-edit
    pkgs.inotify-tools
    pkgs.rustfmt
    pkgs.rust-analyzer
    pkgs.openssl
    pkgs.gnumake
    pkgs.pkg-config
    pkgs.nodejs-12_x
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-language-server
    pkgs.elmPackages.elm-format
    pkgs.postgresql

    pkgs.python # For fucking node-sass
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
