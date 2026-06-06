{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    zoom-us
  ];
}
