{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg
    kdePackages.kdenlive
  ];
}
