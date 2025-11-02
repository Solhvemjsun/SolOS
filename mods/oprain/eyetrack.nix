{ pkgs, ... }:

{
  programs.talon.enable = true;
  environment.systemPackages = with pkgs; [
    jstest-gtk
    opentrack
  ];
}
