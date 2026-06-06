{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.kernelParams = [
    "nvidia.NVreg_EnableGpuFirmware=0"

    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = lib.mkForce false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    nvitop
  ];

}
