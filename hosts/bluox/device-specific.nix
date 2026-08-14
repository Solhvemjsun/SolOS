{ lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "bluox";

  home-manager.sharedModules = [
    {
      programs.niri = {
        settings = {
          layout = {
            default-column-width = lib.mkForce { proportion = 1. / 5.; };
            preset-column-widths = lib.mkForce [
              { proportion = 1. / 5.; }
              { proportion = 1. / 4.; }
              { proportion = 1. / 3.; }
              { proportion = 1. / 2.; }
              { proportion = 2. / 3.; }
              { proportion = 1.; }
            ];
          };
          outputs = {
            "Samsung_G9_49" = {
              name = "Samsung Electric Company Odyssey G93SD HNTL500450";
              mode = {
                width = 5120;
                height = 1440;
                refresh = 240.000;
              };
              scale = 1.0;
              transform.rotation = 0;
              position = {
                x = 0;
                y = 0;
              };
              background-color = "#000000";
              backdrop-color = "#000000";
            };
            "Samsung_G9_57" = {
              name = "Samsung Electric Company Odyssey G95NC HNTY900051";
              mode = {
                width = 7680;
                height = 2160;
                refresh = 240.000;
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
