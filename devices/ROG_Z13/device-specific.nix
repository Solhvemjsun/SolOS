{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./laptop.nix
    ./rog.nix
  ];

  networking.hostName = "Sol_Z13";

  # boot.loader.timeout = null;

  home-manager.sharedModules = [
    {
      services.hyprpaper = {
        settings = {
          preload = lib.mkForce [
            "${../../assets/nixos.png}"
            "${../../assets/sayuki.jpg}"
            "${../../assets/nhk.jpg}"
          ];
          wallpaper = lib.mkForce [
            ",${../../assets/nixos.png}"
            "HDMI-A-1,${../../assets/sayuki.jpg}"
          ];
        };
      };
    }
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128*1024;
    }
  ];
}
