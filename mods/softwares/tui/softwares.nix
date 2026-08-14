{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetuith
    btop
    fastfetch
    gnumake
    openssh
    samba
    unzip
    usbutils
    wget
    zip
  ];
}
