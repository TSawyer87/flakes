{ ... }:
{
  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "y";
      settings = {
        manager = {
          show_hidden = false;
          sort_dir_first = true;
          sort_by = "mtime";
          sort_reverse = true;
          linemode = "size";
          editor = "helix";
        };
      };
    };
  };
}
