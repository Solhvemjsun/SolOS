{ config, pkgs, ... }:
{
  boot = {
    kernelModules = [ "nvidia_uvm" ];
    kernelParams = [ "nvidia-drm.modeset=1" ];
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    nvitop
  ];
  
  environment.sessionVariables.NIXOS_OZONE_WL = "0"; # Fix the glitching of electron apps
}
