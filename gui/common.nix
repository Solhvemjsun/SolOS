{ pkgs, lib, ... }:

{
  ##################
  ## HOME MANAGER ##
  ##################

  home-manager.sharedModules = [ ./commonhome.nix ];

  ##########
  ## GRUB ##
  ##########

  boot = {
    loader.grub = {
      useOSProber = true;
      gfxmodeEfi = "1920x1080";
      minegrub-theme = {
        enable = true;
        splash = "Fiat Lux!";
        boot-options-count = 7;
      };
    };

    plymouth = {
      enable = true;
      theme = "dna";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "dna" ];
        })
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  #############
  ## Greeter ##
  #############

  services.displayManager = {
    defaultSession = "niri";
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
      settings = {
        General.DisplayServer = "wayland";
      };
    };
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --theme 'button=black;action=black;'--cmd niri";
  #       user = "greeter";
  #     };
  #   };
  # };

  #############
  ## DRIVERS ##
  #############

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

  #################
  ## ENVIRONMENT ##
  #################

  environment.sessionVariables.NIXOS_OZONE_WL = lib.mkDefault "1";

  ##############
  ## PACKAGES ##
  ##############

  environment.systemPackages = with pkgs; [
    amberol
    udiskie
    firefox
    gparted
    google-chrome
    haruna
    (pkgs.callPackage ../pkgs/hatsune-miku-cursors/package.nix { })
    kiwix
    libnotify
    libsForQt5.kamoso
    kdePackages.okular
    mediainfo-gui
    neovide
    nextcloud-client
    nautilus
    nautilus-open-any-terminal
    ntfs3g
    onlyoffice-desktopeditors
    remmina
    samba
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        showSessionsByDefault = true;
      };
    })
  ];

  #########
  ## XDG ##
  #########

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

  ###########
  ## FONTS ##
  ###########

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
  ];

  ##################
  ## INPUT METHOD ##
  ##################

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      fcitx5-mozc
      rime-ls
      rime-data
      rime-zhwiki
      rime-japanese
    ];
  };

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    polarity = "dark";
    cursor = {
      package = (pkgs.callPackage ../pkgs/hatsune-miku-cursors/package.nix { });
      name = "miku-cursor";
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
