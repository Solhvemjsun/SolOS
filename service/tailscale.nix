{ pkgs, ... }:

{
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  environment.systemPackages = with pkgs; [
    tailscale
  ];
}
