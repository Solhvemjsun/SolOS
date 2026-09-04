{ lib, ... }:

{
  specialisation."SolOS_KDE".configuration = {
    system.nixos.tags = [ "KDE" ];

    services.displayManager.sddm.enable = lib.mkForce false;
    services.displayManager.gdm.enable = lib.mkForce false;
    services.greetd.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "plasma";

    imports = [ ./launcher.nix ];
  };
}
