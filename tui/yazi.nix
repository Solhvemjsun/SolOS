{ ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [
          1
          3
          4
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
    };
  };
}
