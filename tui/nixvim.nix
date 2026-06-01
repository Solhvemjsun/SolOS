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
      statuscolumn = "%s%=%{v:relnum==0?v:lnum:(v:lnum>line('.')?v:relnum+1:v:relnum)} ";
      clipboard = "unnamedplus";
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

      which-key.enable = true;

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

      rainbow-delimiters = {
        enable = true;
        # settings = {
        # }
      };

      markview.enable = true;

      lualine.enable = true;

      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons.style = "glyph";
        };
      };

      nix.enable = true;

      nvim-tree.enable = true;

      telescope.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };

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
          zls.enable = true;
        };
      };

      lsp-signature.enable = true;

      lspsaga = {
        enable = true;
        settings.beacon.enable = true;
        lightbulb.enable = false;
      };

      autosource.enable = true;

      diffview.enable = true;

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

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };

}
