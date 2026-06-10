{ lib, ... }:

{
  boot.loader.grub.enable = lib.mkForce false;
  networking.useDHCP = lib.mkForce false;
}
