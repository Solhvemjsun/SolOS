{ config, lib, pkgs, ... }:

{
  #########
  ## NIX ##
  #########

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [
    btop
    fastfetch
    git
    gnumake
    openssh
    ranger
    tree
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  home-manager.config =
  { config, lib, pkgs, ... }:
  {
    home.stateVersion = "24.05";
  };
}
