{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "SolXPS26";

  boot.loader.timeout = null;

  boot.resumeDevice = "/dev/disk/by-uuid/74e1f410-06b2-4e79-9e79-b1b6632e68fe";

  home-manager.sharedModules = [
    {
      programs.niri = {
        settings = {
          outputs = {
            "XPS1326Inner" = {
              name = "LG Display 0x0804 Unknown";
              mode = {
                width = 2560;
                height = 1600;
                # refresh = 120.002;
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

}
