{ config, lib, pkgs, ... }:

{
  home.stateVersion = lib.mkDefault "24.05";
  imports = [
    ./home.nix
    ../terminal/nixvim.nix
  ];
}
