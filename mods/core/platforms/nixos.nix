{ lib, pkgs, ... }:

{
  ################
  ## BOOTLOADER ##
  ################

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = lib.mkDefault true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  #############
  ## PACKAGE ##
  #############

  system.stateVersion = "24.05"; # The first version of this config set

  environment.systemPackages = with pkgs; [
    git
    gnumake
    ntfs3g
  ];
}
