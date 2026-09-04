{ lib, ... }:

{
  specialisation."BluxOS_Niri".configuration = {
    system.nixos.tags = [ "Niri" ];

    services.displayManager.sddm.enable = lib.mkForce false;
    services.displayManager.plasma-login-manager.enable = lib.mkForce false;
    services.displayManager.gdm.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "niri";

    imports = [ ./launcher.nix ];
  };
}
