{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./laptop.nix
    ./rog.nix
  ];

  networking.hostName = "Sol_Z13";

  # boot.loader.timeout = null;

  environment.systemPackages = with pkgs; [
    swaybg
  ];

  home-manager.sharedModules = [
    {
      programs.niri.settings = {
        spawn-at-startup = [
          { command = [ "swaybg -m center -i ${../../assets/nixos.png}" ]; }
        ];
      };
    }
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128 * 1024;
    }
  ];
}
