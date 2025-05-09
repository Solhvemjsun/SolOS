{ pkgs, ... }:

{
  #################
  ## ENVIRONMENT ##
  #################

  i18n.defaultLocale = "en_US.UTF-8";

  #########
  ## NIX ##
  #########

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.nh = {
    enable = true;
  };

  ################
  ## BOOTLOADER ##
  ################

  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  #############
  ## DRIVERS ##
  #############

  networking.networkmanager.enable = true; # Network

  ##############
  ## PACKAGES ##
  ##############
  
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
}
