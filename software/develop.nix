{ config, lib, pkgs, ... }:

{
  ####################
  ## REMOTE DESKTOP ##
  ####################

  services.teamviewer.enable = true;

  #############
  ## PACKAGE ##
  #############

  environment.systemPackages = with pkgs; [
    # Management
    github-desktop

    # Programming
    # Rust
    cargo
    gcc
    rustc

    # LSP
    pyright
    nodePackages.typescript-language-server
    rust-analyzer
    rustfmt
    nixfmt-rfc-style

    # Octave
    (octaveFull .withPackages (ps: with ps; [ video ]))

    # Website
    zola

    # Video
    ffmpeg
    opencv

    # Art
    inkscape
    krita

  ];

  ############
  ## NIXVIM ##
  ############

  programs.nixvim.plugins = {

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        # NIX
        nixd.enable = true;

        # Rust
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };

        # Lua
        lua_ls.enable = true;

        # Typescript
        ts_ls.enable = true;

        # Python
        pylsp = {
          enable = true;
          settings.plugins = {
            autopep8.enabled = false;
            black.enabled = false;
            flake8.enabled = false;
            mccabe.enabled = false;
            memestra.enabled = false;
            pycodestyle.enabled = false;
            pydocstyle.enabled = false;
            isort.enabled = false;
            pyflakes.enabled = false;
            pylint.enabled = false;
            pylsp_mypy.enabled = false;
            yapf.enabled = false;
          };  
        };
        basedpyright.enable = true;

        # CSS
        cssls.enable = true;

        # Linux script
        bashls.enable = true;
        zls.enable = true;
      };
    };

    autosource.enable = true;
    
    git-conflict.enable = true;

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          rust = [ "rustfmt" ];
          nix = [ "nixfmt" ];
        };
        formatters = {
          rustfmt = {
            command = lib.getExe pkgs.rustfmt;
          };
          nixfmt = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
          };
        };
      };
    };

  };
}
