{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware-amendment.nix
  ];

  networking.hostName = "SolITX";

  boot.loader.timeout = null;

  system.stateVersion = lib.mkForce "26.05";

  home-manager.sharedModules = [
    {
      programs.niri = {
        settings = {
          layout = {
            default-column-width = lib.mkForce { proportion = 1. / 3.; };
          };
        };
      };
    }
  ];

}
