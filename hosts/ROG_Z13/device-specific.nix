{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./laptop.nix
    ./rog.nix
  ];

  networking.hostName = "Sol_Z13";

  # boot.loader.timeout = null;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128 * 1024;
    }
  ];
}
