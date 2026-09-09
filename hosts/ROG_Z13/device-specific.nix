{ pkgs, ... }:

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
      programs.niri = {
        settings = {
          outputs = {
            "LG OLED TV" = {
              name = "LG Electronics LG TV SSCR2 0x01010101";
              mode = {
                width = 3840;
                height = 2160;
                refresh = 60.000;
              };
              scale = 1.5;
              transform.rotation = 0;
              position = {
                x = 0;
                y = 0;
              };
              background-color = "#000000";
              backdrop-color = "#000000";
            };
          };
        };
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
