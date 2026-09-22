{ lib, ... }:

{
  specialisation."SolOS-Cosmic".configuration = {
    system.nixos.tags = [ "Cosmic" ];

    services.displayManager.regreet.enable = lib.mkForce false;
    services.displayManager.plasma-login-manager.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "cosmic";

    imports = [ ./launcher.nix ];
  };
}
