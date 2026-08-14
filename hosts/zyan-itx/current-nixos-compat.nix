{
  lib,
  pkgs,
  ...
}:

{
  i18n = {
    defaultLocale = lib.mkForce "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
  };

  environment.systemPackages = with pkgs; [
    appimage-run
    bubblewrap
    codex
    curl
    direnv
    fuse
    fuse3
    gcc-unwrapped
    gdrive3
    google-chrome
    google-drive-ocamlfuse
    gtk3
    htop
    libayatana-appindicator
    mesa-demos
    micromamba
    moonlight-qt
    nodejs
    nvidia-container-toolkit
    nvtopPackages.nvidia
    pciutils
    qq
    rclone
    sunshine
    syncthing
    tailscale
    tmux
    uv
    vulkan-tools
    webkitgtk_4_1
    wget
    zellij
    (lib.getOutput "tools" nvidia-container-toolkit)
  ];

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };

    clash-verge.serviceMode = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        gcc-unwrapped
        icu
        libgcc
        libuuid
        libxml2
        openssl
        stdenv.cc.cc
        systemd
        zlib
      ];
    };
  };

  services = {
    flatpak.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    syncthing = {
      enable = true;
      user = "szy";
      dataDir = "/home/szy";
      configDir = "/home/szy/.config/syncthing";
      openDefaultPorts = true;
    };

    sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
    };

    vscode-server.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    uinput.enable = true;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall = {
    enable = true;
    interfaces.tailscale0.allowedTCPPorts = [
      22
      8888
      6006
      7860
      8000
    ];
    allowedTCPPorts = lib.mkDefault [ ];
  };
}
