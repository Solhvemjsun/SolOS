{ pkgs, ... }:

{
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    serviceMode = true;
  };
}
