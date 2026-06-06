{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetuith
    btop
    fastfetch
    gh
    lazygit
    openssh
    samba
    unzip
    usbutils
    wget
    yazi
    zip
  ];
}
