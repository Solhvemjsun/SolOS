{ pkgs, ... }:

{
  #########
  ## NIX ##
  #########

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.nh = {
    enable = true;
  };

  ################
  ## BOOTLOADER ##
  ################

  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        useOSProber = true;
        gfxmodeEfi = "1920x1080";
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [ "ntfs" ];
  };

  #################
  ## ENVIRONMENT ##
  #################

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8"; # Language coding locale

  #############
  ## DRIVERS ##
  #############

  networking.networkmanager.enable = true; # Network

  #############
  ## PACKAGE ##
  #############

  system.stateVersion = "24.05"; # The first version of NixOS on this particular machine.
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    any-nix-shell
    btop
    fastfetch
    git
    gnumake
    htop
    lynx
    openssh
    ranger
    tree
    tty-clock
    udiskie
    unzip
    usbutils
    wget
    yazi
    zip
  ];

  ###########
  ## SHELL ##
  ###########

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

  ############
  ## NIXVIM ##
  ############

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2; # Tab width is 2
    };

    plugins = {
      alpha = {
        enable = true;
        theme = "startify";
      };

      nvim-autopairs.enable = true;

      cmp = {
        enable = true; 
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            # { name = "buffer"; }
            # { name = "cmdline"; }
            { name = "dictionary"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      render-markdown = {
        enable = true;
      };

      lualine.enable = true;

      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons.style = "glyph";
        };
      };

      nix.enable = true;

      nvim-tree = {
        enable = true;
        autoClose = false;
        hijackNetrw = false;
      };

      telescope.enable = true;

      treesitter.enable = true;
    };

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };

}
