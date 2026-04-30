{ pkgs, ... }:
{
  config.boot.kernelPackages = pkgs.nvidia-jetpack.kernelPackages.extend pkgs.nvidia-jetpack.kernelPackagesOverlay;
  hardware.nvidia-jetpack = {
    enable = true;
    som = "orin-nano";
    carrierBoard = "devkit";
  };

  hardware.graphics.enable = true;
}
