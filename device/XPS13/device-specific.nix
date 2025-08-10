{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "SolXPS";

  boot.loader.grub.useOSProber = lib.mkForce false;

  home-manager.sharedModules = [
    {
      programs.fuzzel.settings.main = {
        dpi-aware = lib.mkForce false;
      };
    }
  ];

}
