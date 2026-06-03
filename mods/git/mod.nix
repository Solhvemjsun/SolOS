{ pkgs, ... }:

{
  home-manager.sharedModules = [ ./home.nix ];

  environment.systemPackages = with pkgs; [
    gitFull
    github-cli
    lazygit
    meld
  ];
}
