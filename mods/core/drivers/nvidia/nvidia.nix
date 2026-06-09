{
  config,
  pkgs,
  ...
}:

{
  boot.blacklistedKernelModules = [
    "i915"
    "amdgpu"
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    nvitop
    btop-cuda
  ];

}
