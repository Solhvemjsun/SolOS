{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.useOSProber = lib.mkForce false;
  home-manager.sharedModules = [
    {
      programs.fuzzel.settings.main = {
        dpi-aware = lib.mkForce false;
      };
    }
  ];

}
