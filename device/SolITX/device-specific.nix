{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "SolITX";

  home-manager.sharedModules = [
    {
      programs.niri = {
        settings = {
          layout = {
            default-column-width = lib.mkForce { proportion = 1. / 3.; };
          };
        };
      };

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
            "DP-3,${../../assets/nhk.jpg}"
          ];
        };
      };

    }
  ];

}
