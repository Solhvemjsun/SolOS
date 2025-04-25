{ pkgs, ...}:

{
  #############
  ## Network ##
  #############

  # Refer to https://nixos.wiki/wiki/Tor

  #############
  ## BROWSER ##
  #############

  services.tor.client.enable = true;

  environment.systemPackages = with pkgs; [
    tor-browser
  ];

}
