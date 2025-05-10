{ config, name, lib, pkgs, ... }:

{
  ##########
  ## HOME ##
  ##########

  home = {
    stateVersion = "24.05";
    username = lib.mkDefault name;
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    packages = with pkgs; [
      any-nix-shell
    ];
  };

  ###########
  ## SHELL ##
  ###########

  programs.zsh = {
    enable = true;
    autocd = true;
    initContent = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
      highlight = "fg = #555";
    };
    enableCompletion = true;
    history = {
      size = 10000;
      path = "$HOME/zsh/history";
    };

    shellAliases = {
      ll = "ls -l";
      clock = "tty-clock -s -c -C 6 -t ";
    };

    oh-my-zsh = {
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

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "display"
        "brightness"
        "sound"
        "de"
        "wm"
        "cpu"
        "gpu"
        "disk"
        "memory"
        "swap"
        "wifi"
        "bluetooth"
        "localip"
        "battery"
        "poweradapter"
        "datetime"
      ];
    };
  };

  programs.ranger = {
    enable = true;
    extraPackages = [ pkgs.ueberzugpp ];
    settings = {
      show_hidden = true;
      preview_images_method = "ueberzug";
    };
  };

  #############
  ## DEVELOP ##
  #############

  programs.git = {
    enable = true;
    userName = "Solhvemjsun";
    userEmail = "solhvemjsun@gmail.com";
  };

  ##############
  ## PACKAGES ##
  ##############



}
