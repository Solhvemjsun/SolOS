{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    napari
  ];
}
