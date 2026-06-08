{
  config,
  pkgs,
  lib,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = lib.mkDefault true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  environment.systemPackages = with pkgs; [
    nvitop
    btop-cuda
  ];

}
