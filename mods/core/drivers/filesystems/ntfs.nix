{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}
