{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jstest-gtk
    opentrack
  ];
}
