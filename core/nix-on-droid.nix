{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    vim
    nyancat
    neovim
    git
    gnumake
    openssh
    fastfetch
    aircrack-ng

    # Some common stuff that people expect to have
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

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

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

  #########
  ## ZSH ##
  #########

  programs.zsh = {
    enable = true;
    promptInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
    autosuggestions = {
      enable = true;
      strategy = [ "history" "completion" ];
      highlightStyle = "fg = #555";
    };
    enableCompletion = true;
    histSize = 10000;
    histFile = "$HOME/zsh/history";

    shellAliases = {
      ll = "ls -l";
      clock = "tty-clock -s -c -C 6 -t ";
    };

    ohMyZsh = {
      enable = true;
      theme = "kali-like";
      plugins = [ "git" "sudo" ];
      custom = builtins.toString (pkgs.writeTextDir "/themes/kali-like.zsh-theme" ''
        ZSH_THEME_GIT_PROMPT_PREFIX="%F{cyan}["
        ZSH_THEME_GIT_PROMPT_SUFFIX="] %f"

        configure_prompt() {


            if [[ $UID == 0 || $EUID == 0 ]]; then
                FGPROMPT="%F{red}"
                CYANPROMPT="%F{blue}"
            else
                FGPROMPT="%F{white}"
                CYANPROMPT="%F{blue}"
            fi

            PROMPT=$'$CYANPROMPT┌───\(%B$FGPROMPT%n@%m%b$CYANPROMPT)-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b$CYANPROMPT]$(git_prompt_info)\n$CYANPROMPT└─%B%(#.%F{red}#.$FGPROMPT$)%b%F{reset} '
            RPROMPT=
        }

        configure_prompt
      '');
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "pattern" ];
      styles = {
        default = "none";
        unknown-token = "fg=white,underline";
        reserved-word = "fg=cyan,bold";
        suffix-alias = "fg=073,underline";
        global-alias = "fg=073,bold";
        precommand = "fg=073,underline";
        commandseparator = "fg=blue,bold";
        autodirectory = "fg=073,underline";
        path = "fg=white,bold";
        path_pathseparator = "";
        path_prefix_pathseparator = "";
        globbing = "fg=blue,bold";
        history-expansion = "fg=blue,bold";
        command-substitution = "none";
        command-substitution-delimiter = "fg=magenta,bold";
        process-substitution = "none";
        process-substitution-delimiter = "fg=magenta,bold";
        single-hyphen-option = "fg=073";
        double-hyphen-option = "fg=073";
        back-quoted-argument = "none";
        back-quoted-argument-delimiter = "fg=blue,bold";
        single-quoted-argument = "fg=yellow";
        double-quoted-argument = "fg=yellow";
        dollar-quoted-argument = "fg=yellow";
        rc-quote = "fg=magenta";
        dollar-double-quoted-argument = "fg=magenta,bold";
        back-double-quoted-argument = "fg=magenta,bold";
        back-dollar-quoted-argument = "fg=magenta,bold";
        assign = "none";
        redirection = "fg=blue,bold";
        comment = "fg=black,bold";
        named-fd = "none";
        numeric-fd = "none";
        arg0 = "fg=cyan";
        bracket-error = "fg=red,bold";
        bracket-level-1 = "fg=blue,bold";
        bracket-level-2 = "fg=073,bold";
        bracket-level-3 = "fg=magenta,bold";
        bracket-level-4 = "fg=yellow,bold";
        bracket-level-5 = "fg=cyan,bold";
        cursor-matchingbracket = "standout";
      };
    };

  };
  users.defaultUserShell = pkgs.zsh;
}
