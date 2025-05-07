{ config, lib, pkgs, ... }:

{
  users.users.Sol = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };
}
