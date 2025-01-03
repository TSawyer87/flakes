{ pkgs, host, username, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
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
      # fastfetch
       if [ -f $HOME/.zshrc-personal ]; then
         source $HOME/.zshrc-personal
       fi
       source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
       source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
       # You can now call pokemon-colorscripts from here
       function random_pokemon() {
         ${pkgs.pokemon-colorscripts}/bin/pokemon-colorscripts -r --no-title
       }
       random_pokemon
       function rbs() {
    local host="$1"
    local username="$2"
    local duration=3600 # duration in seconds, here set to 1 hour

    echo "Starting performance mode"
    sudo cpupower frequency-set -g performance || { echo "Failed to set performance mode"; return 1; }

    # Perform the OS switch
    nh os switch --hostname ${host} --update "/home/${username}/flakes" || echo "Failed to switch OS"

    # Wait for the specified duration before switching back to powersave
    echo "Performance mode active for $duration seconds"
    sleep "$duration"

    echo "Switching back to powersave mode"
    sudo cpupower frequency-set -g powersave || echo "Failed to switch back to powersave mode"
}

# Usage: rbs <hostname> <username>
       eval "$(zoxide init zsh)"
       eval "$(mcfly init zsh)"
       eval "$(direnv hook zsh)"
       export MANPAGER='nvim +Man!'
       export MCFLY_KEY_SCHEME=vim
       export MCFLY_FUZZY=2
       export MCFLY_RESULTS=50
       export MCFLY_RESULTS_SORT=LAST_RUN
       export MCFLY_INTERFACE_VIEW=BOTTOM
       export TERM=xterm-256color
    '';
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${host} /home/${username}/flakes";
      ft = "nh os test --hostname ${host} /home/${username}/flakes"; # dont save generation to boot menu
      fu = "nh os switch --hostname ${host} --update /home/${username}/flakes";
      rebuild = "/home/jr/scripts/performance_hook.sh";
      ncg =
        "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      opts = "man home-configuration.nix";
      zed = "zeditor";
      lg = "lazygit";
      ip = "ip -color";
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      egrep = "grep -E --color=auto";
      fgrep = "grep -F --color=auto";
      grep = "grep --color=auto";
      vdir = "vdir --color=auto";
      dir = "dir --color=auto";
      v = "nvim";
      cat = "bat --style snip --style changes --style header";
      l = "eza -lh --icons=auto"; # long list
      ls = "eza --icons=auto --group-directories-first --icons"; # short list
      ll = "eza -lh --icons --grid --group-directories-first --icons";
      la = "eza -lah --icons --grid --group-directories-first --icons";
      ld = "eza -lhD --icons=auto";
      lt = "eza --icons=auto --tree"; # list folder as tree
      rbs = "echo starting performance mode && sudo cpupower frequency-set -g performance && nh os switch --hostname ${host} --update /home/${username}/flakes"; # Amd pstate governor
      powersave = "sudo cpupower frequency-set -g powersave"; # Amd pstate governor
      # Get the error messages from journalctl
      jctl = "journalctl -p 3 -xb";

      mkdir = "mkdir -p";
      yz = "yazi";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };

}
