{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # specify which packages to add to the shell environment
  packages = [
    pkgs.elixir_1_11
    pkgs.elixir_ls

    pkgs.nodejs-12_x
    pkgs.elmPackages.elm-language-server

    pkgs.rustc
    pkgs.rustfmt
    pkgs.rust-analyzer
    pkgs.cargo
    pkgs.cargo-make
    pkgs.cargo-edit

    pkgs.postgresql_12
    pkgs.openssl
    pkgs.pkgconfig
    pkgs.inotify-tools
  ];
  # add all the dependencies, of the given packages, to the shell environment
  inputsFrom = with pkgs; [ hello gnutar ];
}
