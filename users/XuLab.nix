{ config, lib, pkgs, ... }:

{
  users.users.XuLab = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };
}
