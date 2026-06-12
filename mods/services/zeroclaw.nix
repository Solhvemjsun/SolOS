{ pkgs, ... }:

{
  # Create the user
  users.users.zeroclaw = {
    isNormalUser = true;
    uid = 1024;
    group = "agent";
    createHome = true;
  };
  users.groups.agent = { };

  systemd.services.zeroclaw = {
    description = "Zeroclaw's service";

    # Ensure Network
    after = [ "network-online.target" ];
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
      gitFull
      nix
      nixpkgs-fmt
      cargo
      rustc
      nodejs
    ];

    serviceConfig = {
      User = "zeroclaw";
      ExecStart = "${pkgs.zeroclaw}/bin/zeroclaw daemon";
      WorkingDirectory = "/home/zeroclaw/.zeroclaw/workspace";
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
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/986/bus"
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
    serviceConfig.ExecStart = "${pkgs.chromedriver}/bin/chromedriver --port=9515";
  };
}
