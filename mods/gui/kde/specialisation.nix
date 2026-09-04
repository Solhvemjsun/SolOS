{ lib, ... }:

{
  specialisation."SolOS_KDE".configuration = {
    system.nixos.tags = [ "KDE" ];

    services.displayManager.regreet.enable = lib.mkForce false;
    services.displayManager.gdm.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "plasma";

    imports = [ ./launcher.nix ];
  };
}
