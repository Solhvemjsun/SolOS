{ lib, ... }:

{
  specialisation."SolOS-GNOME".configuration = {
    system.nixos.tags = [ "GNOME" ];

    services.displayManager.regreet.enable = lib.mkForce false;
    services.displayManager.plasma-login-manager.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "gnome";

    imports = [ ./launcher.nix ];
  };
}
