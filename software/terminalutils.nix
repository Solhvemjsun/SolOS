{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lynx # Browser
    wget # Downloader
    yazi# File Manager
    zip # Compress
    unzip # Decompress
    usbutils # Query USB devices
    tty-clock # Digital clock
  ];
}
