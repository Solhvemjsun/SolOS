{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./razer.nix
  ];

  networking.hostName = "SolITX";

  boot.loader.timeout = null;

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
