{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    nextcloud-talk-desktop
    element-desktop
    slack
    zoom-us
  ];
}
