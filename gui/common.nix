{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    udiskie
  ];
}

