{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "";
    hash = "";
  };
in {
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
          editor = "nvim";
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
        };
      };
      plugins = {
        chmod = "${yazi-plugins}/chmod.yazi";
        full-border = "${yazi-plugins}/full-border.yazi";
        toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
        starship = pkgs.fetchFromGitHub {
          owner = "Rolv-Apneseth";
          repo = "starship.yazi";
          rev = "...";
          sha256 = "sha256-...";
        };
      };

      initLua =
        "	require(\"full-border\"):setup()\n	require(\"starship\"):setup()\n";

      keymap = {
        manager.prepend_keymap = [
          {
            on = "T";
            run = "plugin toggle-pane max-preview";
            desc = "Maximize or restore the preview pane";
          }
          {
            on = [ "c" "m" ];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
        ];
      };
    };
  };
}
