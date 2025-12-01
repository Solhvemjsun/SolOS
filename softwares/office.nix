{ pkgs, ... }:

{
  services.teamviewer.enable = true;

  environment.systemPackages = with pkgs; [
    slack
    zoom-us
    wemeet
    onedrive
    onedriver
    onedrivegui
  ];
}
