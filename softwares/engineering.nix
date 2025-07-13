{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad-wayland
    kicad
  ];
}
