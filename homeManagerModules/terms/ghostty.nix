{
  pkgs,
  lib,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      # theme = "Dracula";
      # theme = "catppuccin-mocha";
      keybind = [
        # "alt+n=new_window"
        # "alt+t=new_tab"
        # "alt+h=new_split:down"
        # "alt+v=new_split:right"
        # "alt+one=goto_tab:1"
        # "alt+two=goto_tab:2"
        # "alt+three=goto_tab:3"
        # "alt+four=goto_tab:4"
        # "alt+five=goto_tab:5"
        # "alt+six=goto_tab:6"
        # "ctrl+comma=open_config"
        # "ctrl+enter=toggle_fullscreen"
        # "ctrl+shift+q=close_window"
        # "ctrl+r>h=resize_split:left"
        # "ctrl+r>l=resize_split:right"
        # "ctrl+r>j=resize_split:bottom"
        # "ctrl+r>k=resize_split:top"
        "ctrl+h=goto_split:left"
        "ctrl+j=goto_split:bottom"
        "ctrl+k=goto_split:top"
        "ctrl+l=goto_split:right"
        "ctrl+page_up=jump_to_prompt:-1"
        # "ctrl+shift+z toggle_split_zoom"
      ];
      font-size = lib.mkForce 12;
      font-family = "Fira-Code-Mono Nerd Font";
      window-decoration = false;
      confirm-close-surface = false;
      cursor-style = "block";
      cursor-style-blink = false;

      unfocused-split-opacity = 0.9;
      background-opacity = 0.6;
      background-blur-radius = 20;
      command = "${pkgs.nushell}/bin/nu";

      window-theme = "dark";

      # Disables ligatures
      font-feature = ["-liga" "-dlig" "-calt"];
    };
  };
}
