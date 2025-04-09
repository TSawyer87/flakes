{...}: {
  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
      sensibleOnTop = true;
      terminal = "screen-256color";
      # prefix = "`";
      extraConfig = ''
        unbind C-b
        set-option -g prefix `
        set-option -g mouse on
        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
      '';
    };
  };
}
