{ lib, pkgs, ... }:

{
  boot = lib.mkForce {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };
}
