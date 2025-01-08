{ ... }: {
  programs.ghostty = {
    enable = true;
    # keybindings = {
    #   "super+c" = "copy_to_clipboard";
    #
    #   "super+shift+h" = "goto_split:left";
    #   "super+shift+j" = "goto_split:bottom";
    #   "super+shift+k" = "goto_split:top";
    #   "super+shift+l" = "goto_split:right";
    #
    #   "ctrl+page_up" = "jump_to_prompt:-1";
    # };
    settings = {
      font-size = 14;
      font-family = "Fira-Code-Mono Nerd Font";
      window-decoration = false;
      confirm-close-surface = false;

      # The default is a bit intense for my liking
      # but it looks good with some themes
      unfocused-split-opacity = 0.9;
      background-opacity = 0.8;
      background-blur-radius = 20;

      # Some macOS settings
      window-theme = "dark";

      # Disables ligatures
      font-feature = [ "-liga" "-dlig" "-calt" ];
    };
  };
}
