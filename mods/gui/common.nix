{ pkgs, lib, ... }:

{
  ##########
  ## GRUB ##
  ##########

  boot = {
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
  };

  #############
  ## GREETER ##
  #############

  services.displayManager.sddm = {
    wayland.enable = lib.mkDefault true;
    settings.General.DisplayServer = "wayland";
  };

  #############
  ## DRIVERS ##
  #############

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      Input = {
        UserspaceHID = true;
      };
    };
  };

  services.blueman.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable LAN file sharing and printing
  services.gvfs.enable = true;
  services.samba-wsdd.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = false;
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
    f3d
    # geogebra6
    gparted
    kitty
    kiwix
    libnotify
    kdePackages.kamoso
    kdePackages.isoimagewriter
    kdePackages.okular
    udiskie
    vlc
  ];

  #########
  ## XDG ##
  #########

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        "x-terminal-emulator" = "kitty.desktop";
        "video/" = "vlc.desktop";
        "audio/" = "vlc.desktop";
        "text/" = "nvim.desktop";
        "model/" = "f3d.desktop";
        "application/pdf" = "okular.desktop";
      };
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
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
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
      fcitx5-material-color
      fcitx5-mozc
      qt6Packages.fcitx5-chinese-addons
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-minecraft
    ];
  };
}
