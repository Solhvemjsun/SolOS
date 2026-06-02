{ pkgs, ... }:

{
  home-manager.sharedModules = [ ./github_home.nix ];

  environment.systemPackages = with pkgs; [
    gitFull
    github-cli
    lazygit
    meld
  ];
}
