{ config, lib, pkgs, ... }:

{
  #################
  ## ENVIRONMENT ##
  #################

  time.timeZone = "America/Los_Angeles";

  #############
  ## PACKAGE ##
  #############

  system.stateVersion = "24.05"; # The first version of NixOS on this particular machine.
  
  nixpkgs.config.allowUnfree = true;

  ##################
  ## HOME MANAGER ##
  ##################

  home-manager = {
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
  
}
