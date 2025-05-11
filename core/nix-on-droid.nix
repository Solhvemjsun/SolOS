{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment = {
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
      any-nix-shell

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

  user = {
    userName = "Sol";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/Los_Angeles";

  home-manager = {
    config = ./home.nix;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
  };

}
