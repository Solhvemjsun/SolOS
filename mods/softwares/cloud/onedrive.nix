{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    onedrive
    onedriver
    onedrivegui
  ];
}
