{ lib, pkgs, ... }:

{
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

    keymaps = [
      {
        mode = "n";
        key = "<C-Tab>";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
          desc = "Toggle nvim-tree with Ctrl+Tab";
        };
      }
    ];

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
            { name = "buffer"; }
          ];
          mapping = {
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
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
        openOnSetup = true;
        hijackUnnamedBufferWhenOpening = true;
        disableNetrw = true;
        hijackNetrw = true;
      };

      telescope.enable = true;

      treesitter.enable = true;

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
            installRustfmt = true;
          };

          # Clang
          clangd.enable = true;

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

      lsp-signature.enable = true;

      lsp-format.enable = true;

      lspsaga = {
        enable = true;
        beacon.enable = true;
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

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };

}
