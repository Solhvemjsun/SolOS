{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clash-verge-rev
    discord
    element-desktop
    nextcloud-talk-desktop
    qq
    slack
    telegram-desktop
    zoom-us
  ];
}
