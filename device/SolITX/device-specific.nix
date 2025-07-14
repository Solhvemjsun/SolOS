{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
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
            "${../../assets/sayuki.png}"
          ];
          wallpaper = lib.mkForce [
            ",${../../assets/nixos.png}"
            "HDMI-A-1,${../../assets/sayuki.png}"
          ];
        };
      };

    }
  ];

}
