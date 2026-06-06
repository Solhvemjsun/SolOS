{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    qq
    telegram-desktop
  ];
}
