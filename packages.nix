{ pkgs ? import <nixpkgs> { } }:
{
  base = [
    pkgs.openssl
    pkgs.gnumake
    pkgs.inotify-tools
  ];

  elixir = {
    base = [
      pkgs.elixir_1_11
      pkgs.beamPackages.hex
    ];

    dev = [
      pkgs.elixir_ls
    ];

    test = [ ];
  };

  elm = {
    base = [
      pkgs.nodejs-12_x
      pkgs.pkg-config
    ];

    dev = [
      pkgs.elmPackages.elm-language-server
      pkgs.elmPackages.elm-format
      pkgs.python # For fucking node-sass
    ];

    test = [ ];
  };

  rust = {
    base = [
      pkgs.rustc
      pkgs.cargo
    ];

    dev = [
      pkgs.elmPackages.elm-language-server
      pkgs.elmPackages.elm-format
      pkgs.python # For fucking node-sass
      pkgs.rustfmt
      pkgs.rust-analyzer
      pkgs.cargo-make
      pkgs.cargo-edit
    ];

    test = [ ];
  };
}
