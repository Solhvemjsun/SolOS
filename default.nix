{ config, lib, pkgs, ... }:

{
  #########
  ## NIX ##
  #########

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.nh = {
    enable = true;
  };

  #################
  ## ENVIRONMENT ##
  #################

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8"; # Language coding locale

  #############
  ## PACKAGE ##
  #############

  system.stateVersion = "24.05"; # The first version of NixOS on this particular machine.
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    git
    gnumake
    openssh
    ranger
    tree
    
    # neovim

    # Some common stuff that people expect to have
    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  ##################
  ## HOME MANAGER ##
  ##################

  home-manager = {
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
    config.home.stateVersion = "24.05";
  };
  
}
