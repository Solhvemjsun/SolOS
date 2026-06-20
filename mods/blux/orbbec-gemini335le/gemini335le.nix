{ config, pkgs, ... }:
{
  services.orbbec-gemini335le = {
    enable = true;
    interface = "eth0";
    hostAddress = "192.168.1.3";
    prefixLength = 24;
    profileName = "Auto Ethernet"; # Name of your network adaptor
    configureNetworkManager = true;
    trustFirewallInterface = true;
    installViewer = true;
  };
}
