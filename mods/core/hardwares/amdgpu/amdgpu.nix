{ config, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];

  environment.systemPackages = with pkgs; [
    amdgpu_top
  ];
}
