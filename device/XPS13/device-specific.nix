{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  home-manager.sharedModules = [
    {
      programs.fuzzel.settings.main = {
        dpi-aware = lib.mkForce false;
      };
    }
  ];

}
