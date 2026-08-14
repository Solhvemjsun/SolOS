{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "xe.force_probe=*" ];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
}
