{ config, lib, pkgs, ... }:

{
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/Los_Angeles";

  environment = {
    motd = ''
      Fiat Nix!
    '';
    etcBackupExtension = ".bak"; 
    packages = with pkgs; [
      vim
      zsh
      nyancat
      neovim
      git
      gnumake
      openssh
      fastfetch
      aircrack-ng

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
  };

  user.shell = "${pkgs.zsh}/bin/zsh";

  home-manager = {
    config = { ... }:
    {
      imports = [
        ./home.nix
        ../terminal/nixvim.nix
      ];
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
  };

  stylix = {
    enable = true;
    polarity = "dark";
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
      nixvim.enable = false;
    };
  };
}
