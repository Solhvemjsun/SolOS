{ config, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.sharedModules = [
    ./home.nix
  ];
}
