{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    amberol
    spotify
  ];
}
