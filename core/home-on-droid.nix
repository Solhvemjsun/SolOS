{ config, lib, pkgs, ... }:

{
  imports = [
    ./home.nix
    ../terminal/nixvim.nix
  ];
}
