{ lib, pkgs, ... }:

{
  ##################
  ## HOME MANAGER ##
  ##################

  home-manager.sharedModules = [ ./home.nix ];

  #############
  ## DRIVERS ##
  #############

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable LAN file sharing and printing
  services.gvfs.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.enable = true;

  # Enable harddisk automount
  services.udisks2.enable = true;

  ##############
  ## PACKAGES ##
  ##############

  environment.systemPackages = with pkgs; [
    brightnessctl
    candy-icons
    hyprland-qtutils
    hyprnotify
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprshot
    imv
    libnotify
    light
    pamixer
    playerctl
    seahorse
    selectdefaultapplication
    sweet-folders
    wayvnc
    wl-screenrec
    zathura
  ];

  ##############
  ## HYPRLAND ##
  ##############

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --theme 'button=black;action=black;'--cmd Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = lib.mkDefault "1";
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  xdg = {
    mime = {
      enable = true; # WIP
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = [ "kitty.desktop" ];
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
  ];

  programs.dconf.enable = true;

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    polarity = "dark";
    cursor = {
      package = (pkgs.callPackage ../../pkgs/breeze-hacked-cursor-theme-hyprcursor/package.nix {});
      name = "Breeze_Hacked";
      size = 64;
    };
    base16Scheme = {
      system = "base24";
      name = "Eclipse";
      author = "Sol";
      variant = "dark";
      base00 = "000000";
      base01 = "131313";
      base02 = "2a3141";
      base03 = "343d50";
      base04 = "d6dae4";
      base05 = "c1c8d7";
      base06 = "e3e6ed";
      base07 = "ffffff";
      base08 = "f71118";
      base09 = "ecb90f";
      base0A = "0f80d5";
      base0B = "2cc55d";
      base0C = "0f80d5";
      base0D = "2a84d2";
      base0E = "4e59b7";
      base0F = "7b080c";
      base10 = "0a0a0a";
      base11 = "060606";
      base12 = "ff0000";
      base13 = "ffff00";
      base14 = "00ff00";
      base15 = "00ffff";
      base16 = "0000ff";
      base17 = "ff00ff";
    };
    targets = {
      grub.enable = false;
      nixvim.enable = false;
      plymouth.enable = false;
    };
  }; 

}
