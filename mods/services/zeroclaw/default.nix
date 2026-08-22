{ pkgs, ... }:

let
  zeroclaw = pkgs.zeroclaw.overrideAttrs (oldAttrs: {
    cargoBuildFlags = (oldAttrs.cargoBuildFlags or [ ]) ++ [
      "--features"
      "channel-nextcloud"
    ];
  });
in
{
  # Create the user
  users.users.zeroclaw = {
    isNormalUser = true;
    group = "zeroclaw";
    createHome = true;
  };
  users.groups.zeroclaw = { };

  systemd.services.zeroclaw = {
    description = "Zeroclaw service";

    # Ensure Network
    after = [
      "network-online.target"
      "chromedriver.service"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    # Toolchains
    path = with pkgs; [
      # System operations
      coreutils
      bash
      fastfetch

      # Files
      fd
      ripgrep
      zip
      unzip
      gnutar
      gzip

      # Network oprations
      openssh
      curl
      wget
      chromium
      chromedriver

      # Develop
      git
      nix
      nixpkgs-fmt
      cargo
      rustc
      nodejs
    ];

    serviceConfig = {
      User = "zeroclaw";
      ExecStart = "${zeroclaw}/bin/zeroclaw daemon";
      WorkingDirectory = "/home/zeroclaw/.zeroclaw";
      RuntimeDirectory = "zeroclaw";

      BindReadOnlyPaths = [ "/run/dbus/system_bus_socket" ];
      BindPaths = [ "/dev/shm" ];

      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_INET"
        "AF_INET6"
      ];

      Environment = [
        "HOME=/home/zeroclaw"
        "XDG_CONFIG_HOME=/home/zeroclaw/.config"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
        "CHROME_PATH=${pkgs.chromium}/bin/chromium"
        "PUPPETEER_EXECUTABLE_PATH=${pkgs.chromium}/bin/chromium"
      ];

      # Auto restart
      Restart = "always";
      RestartSec = "5s";

      # Safety Settings
      ProtectSystem = "full"; # File permission
      NoNewPrivileges = true; # No permission upgrade by sudo
      RestrictSUIDSGID = true; # No SUID
      ProtectKernelTunables = true; # Read-only kernel parameters
      ProtectKernelModules = true; # Prevent from loading kernel parameters
      ProtectControlGroups = true; # Restricted from CGroups
      ProtectClock = true; # Prevent from changing clock time
      ProtectHostname = true; # Prevent from changing hostname
    };
  };

  systemd.services.chromedriver = {
    description = "Selenium ChromeDriver";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.chromium ];
    serviceConfig = {
      User = "zeroclaw";
      ExecStart = "${pkgs.chromedriver}/bin/chromedriver --port=9515";
    };
  };
}
