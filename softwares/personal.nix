{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    # element-desktop
    nextcloud-talk-desktop
    qq
    spotify
    telegram-desktop
  ];
}
