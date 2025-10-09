{ pkgs, lib, ... }:

{
  #########
  ## NIX ##
  #########

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
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
        enable = lib.mkDefault true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  #################
  ## ENVIRONMENT ##
  #################

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8"; # Language coding locale

  #############
  ## DRIVERS ##
  #############

  networking.networkmanager.enable = true; # Network

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
    tree
    tty-clock
    unzip
    usbutils
    wget
    zip
  ];
}
