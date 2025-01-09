{ ... }: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      keybind = [
        # "ctrl+a>n=new_window"
        # "ctrl+a>t=new_tab"
        # "ctrl+a>h=move_split:left"
        # "ctrl+a>l=move_split:right"
        # "ctrl+a>j=move_split:bottom"
        # "ctrl+a>k=move_split:top"
        "ctrl+alt+h=goto_split:left"
        "ctrl+alt+j=goto_split:bottom"
        "ctrl+alt+k=goto_split:top"
        "ctrl+alt+l=goto_split:right"
        "ctrl+page_up=jump_to_prompt:-1"
      ];
      font-size = 14;
      font-family = "Fira-Code-Mono Nerd Font";
      window-decoration = false;
      confirm-close-surface = false;

      unfocused-split-opacity = 0.9;
      background-opacity = 0.8;
      background-blur-radius = 20;

      window-theme = "dark";

      # Disables ligatures
      font-feature = [ "-liga" "-dlig" "-calt" ];
    };
  };
}
