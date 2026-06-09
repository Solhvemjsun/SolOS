{ lib, ... }:

{
  boot.loader.grub.enable = lib.mkForce false;
  networking.useDHCP = lib.mkForce false;

  # Performance
  powerManagement.enable = lib.mkForce false;
  services.upower.enable = lib.mkForce false;

  networking.networkmanager.enable = lib.mkForce false;
  networking.wireless.enable = lib.mkForce false;

  hardware.bluetooth.enable = lib.mkForce false;
  services.printing.enable = lib.mkForce false;
  services.udisks2.enable = lib.mkForce false;

  boot.supportedFilesystems = lib.mkForce [
    "ext4"
    "vfat"
  ];
}
