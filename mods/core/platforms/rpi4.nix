{ lib, pkgs, ... }:

{
  boot = lib.mkForce {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd.availableKernelModules = [
      "usbhid"
      "usb_storage"
    ];
  };
}
