{ pkgs ? import <nixpkgs> { } }:
let
  packages = import ./packages.nix { };
in
pkgs.mkShell {
  # specify which packages to add to the shell environment
  packages = [
    packages.base
    packages.elixir.base
    packages.elixir.test
  ];

  shellHook = ''
  cd backend && mix deps.get && mix local.rebar --force && cd ../
  '';
}
