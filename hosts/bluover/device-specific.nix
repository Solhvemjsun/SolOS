{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "bluover";

  environment.systemPackages = [
    pkgs.docker-compose
  ];

  users.users.blux.extraGroups = [
    "docker"
    "podman"
  ];

  myServices.sftpgo = {
    enable = true;
    listenPort = 36835;
    hostName = "drive.blux.wang";
  };

  myServices.cfTunnel = {
    enable = true;
    tokenFile = "/var/lib/cloudflare-tunnel/token";
  };

  # === 12TB HDD Storage ===
  fileSystems."/mnt/storage12t" = {
    device = "/dev/disk/by-label/storage12t";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
    ];
  };

  home-manager.sharedModules = [
    {
      programs.niri = {
        settings = {
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
