{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helm
    ardour
  ];
}
