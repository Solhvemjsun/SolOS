{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    remmina
    wayvnc
  ];

}
