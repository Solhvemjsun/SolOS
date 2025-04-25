{ config, lib, pkgs, ... }:

{
  #############
  ## DRIVERS ##
  #############

  services.libinput.enable = true; # Enable touchpad

  services.fprintd.enable = true; # Enable fingerprint reader
}
