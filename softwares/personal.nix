{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clash-verge-rev
    discord
    element-desktop
    nextcloud-talk-desktop
    qq
    spotify
    telegram-desktop
  ];
}
