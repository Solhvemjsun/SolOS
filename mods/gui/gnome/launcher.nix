{ ... }:

{
  services.xserver.displayManager.gdm.enable = true;

  imports = [ ./default.nix ];
}
