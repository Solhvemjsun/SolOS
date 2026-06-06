{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nextcloud-talk-desktop
    element-desktop
  ];
}
