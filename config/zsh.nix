{
  pkgs,
  host,
  username,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
    };
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
      export MCFLY_KEY_SCHEME=vim
      export MCFLY_FUZZY=2
      export MCFLY_RESULTS=50
      export MCFLY_RESULTS_SORT=LAST_RUN
      export MCFLY_INTERFACE_VIEW=BOTTOM
      setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      setopt nocaseglob                                               # Case insensitive globbing
      setopt rcexpandparam                                            # Array expension with parameters
      setopt nocheckjobs                                              # Don't warn about running processes when exiting
      setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      setopt nobeep                                                   # No beep
      setopt appendhistory                                            # Immediately append history instead of overwriting
      setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
      setopt autocd                                                   # if only directory path is entered, cd there.
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushdminus
    '';
    initExtra = ''
      fastfetch
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      eval "$(zoxide init zsh)"
      eval "$(mcfly init zsh)"
      export MANPAGER='nvim +Man!'
      # fzf
      export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
      export FZF_CTRL_T_OPTS="
      --walker-skip .git,node_modules,target
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"
      export FZF_DEFAULT_OPTS="--height 60% \
      --border sharp \
      --layout reverse \
      --color '$FZF_COLORS' \
      --prompt '∷ ' \
      --pointer ▶ \
      --marker ⇒"
      export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"
      export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
    '';
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${host} /home/${username}/flakes";
      fu = "nh os switch --hostname ${host} --update /home/${username}/flakes";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      opts = "man home-configuration.nix";
      zed = "zeditor";
      lg = "lazygit";
      v = "nvim";
      cat = "bat";
      l = "eza -lh --icons=auto"; # long list
      ls = "eza --icons=auto"; # short list
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      ld = "eza -lhD --icons=auto";
      lt = "eza --icons=auto --tree"; # list folder as tree
      mkdir = "mkdir -p";
      yz = "yazi";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../../";
    };
  };

}
