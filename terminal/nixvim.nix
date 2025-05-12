{ pkgs, lib, config, ... }:

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
  };

}
