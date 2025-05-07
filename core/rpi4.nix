{ lib, pkgs, ... }:

{
  boot = lib.mkForce {
    kernelPackages = pkgs.legacyPackages.aarch64-linux.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };

  sdImage = {
    populateFirmwareCommands = ''
      mkdir -p firmware
      cp -r nixpkgs.legacyPackages.aarch64-linux.raspberrypifw/share/raspberrypi/boot/* firmware/
    '';
    populateRootCommands = ''
      mkdir -p ./files/boot
      pkgs.legacyPackages.aarch64-linux.u-boot-rpi4/u-boot.bin -> ./files/boot/
    '';
    imageName = "nixos-sd-image-aarch64-linux-rpi4.img";
    compressImage = true;
  };
}
