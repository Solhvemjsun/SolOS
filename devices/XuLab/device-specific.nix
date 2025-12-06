{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "XuLab";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 1024*1024;
    }
  ];

  fileSystems."/mnt/datafx4t" = {
    device = "/dev/disk/by-uuid/4F1746A15594B0F9";
    fsType = "ntfs";
  };
}
