{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gitFull
    github-cli
  ];
}
