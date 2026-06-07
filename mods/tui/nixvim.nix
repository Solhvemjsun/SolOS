{ lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorscheme = "default";
    opts = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2; # Tab width is 2
      statuscolumn = "%s%=%{v:relnum==0?v:lnum:(v:lnum>line('.')?v:relnum+1:v:relnum)} ";
      clipboard = "unnamedplus";
    };
    extraPackages = with pkgs; [
      wl-clipboard
    ];

    #################
    ## Keybindings ##
    #################

    globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle Explorer";
      }
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find Files";
      }

      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>LazyGit<cr>";
        options.desc = "Open LazyGit";
      }
    ];

    plugins = {
      ########
      ## UI ##
      ########

      alpha = {
        enable = true;
        theme = "startify";
      };

      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons.style = "glyph";
        };
      };

      bufferline.enable = true; # Top line file tabs
      lualine.enable = true; # Bottom line
      telescope.enable = true; # Fuzzy search (<space> f)
      which-key.enable = true; # Shortcut hint
      neo-tree.enable = true; # File viewer (<space> e)

      ##############
      ## Renderer ##
      ##############

      markview.enable = true; # Render Markdown files
      rainbow-delimiters.enable = true;

      #############
      ## Editing ##
      #############

      lsp-signature.enable = true; # Show function's parameters

      nvim-autopairs.enable = true; # Auto complete signs like parenthesis

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };

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
            "<CR>" = "cmp.mapping.confirm({ select = false })";
          };
        };
      };

      #########
      ## Git ##
      #########

      lazygit.enable = true; # git interface (<space> g)
      gitsigns.enable = true; # Git status hint
      diffview.enable = true; # View git diff

      ##############
      ## Language ##
      ##############

      nix.enable = true; # Handle Nix language logic

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
          ruff.enable = true;
          basedpyright.enable = true;

          # CSS
          cssls.enable = true;

          # Linux script
          bashls.enable = true;
        };
      };

      lspsaga = {
        enable = true;
        settings = {
          implement.enable = true;
          beacon.enable = true;
          symbol_in_winbar = false;
          lightbulb.enable = false;
        };
      };

      ###############
      ## Formatter ##
      ###############

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            rust = [ "rustfmt" ];
            nix = [ "nixfmt" ];
            python = [ "ruff_format" ];
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
  };

}
