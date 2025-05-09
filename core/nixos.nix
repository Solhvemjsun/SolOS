{ pkgs, ... }:

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
    # kernelPackages = pkgs.linuxPackages_zen.override {
    #   argsOverride = {
    #     version = "6.14.4";
    #     sha256 = "186rrmsi5y1nwhrd0f1bxjmkr5bhlagr0ih6pfdp5ks25is721ca";
    #   };
    # };
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
    ranger
    tree
  ];

}
