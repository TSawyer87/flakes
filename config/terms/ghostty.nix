{ ... }: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      # Correct keybind format
      keybind = [
        "super+c=copy_to_clipboard"
        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+l=goto_split:right"
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
