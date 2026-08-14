{ lib, ... }:

{
  specialisation."BluxOS_KDE".configuration = {
    system.nixos.tags = [ "KDE" ];

    services.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.gdm.enable = lib.mkForce false;
    services.greetd.enable = lib.mkForce true;
    services.displayManager.defaultSession = lib.mkForce "plasma";

    imports = [ ./launcher.nix ];
  };
}
