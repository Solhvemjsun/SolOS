{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    collabora-desktop
  ];
}
