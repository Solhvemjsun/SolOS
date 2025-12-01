{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    orca-slicer
    bambu-studio
  ];
}
