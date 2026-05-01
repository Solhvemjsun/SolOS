{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zeroclaw
  ];
  networking.firewall.allowedTCPPorts = [ 42617 ];
}
