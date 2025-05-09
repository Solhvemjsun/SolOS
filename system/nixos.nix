{ pkgs, ... }:

{
  ################
  ## BOOTLOADER ##
  ################

  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  #############
  ## DRIVERS ##
  #############

  networking.networkmanager.enable = true; # Network

}
