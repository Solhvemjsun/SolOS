{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "XuLab";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 1024*1024;
    }
  ];
}
