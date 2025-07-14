{ ... }:

{
  imports = [ ./hardware-configuration.nix ];
  home-manager.sharedModules = [ ./home.nix ];
}
