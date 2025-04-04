{
  pkgs,
  host,
  username,
  inputs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      package = pkgs.oh-my-zsh;
      enable = true;
      plugins = ["git" "sudo" "rust" "fzf"];
    };
    profileExtra = ''
      # if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      # fi
      autoload -U compinit
      compinit
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
             source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
             # source <(jj util completion zsh)
             #pokemon-colorscripts -r

             nix-files() {
               nix-locate -w "$1" | fzf --preview="bat --color=always --style=numbers --line-range=:100 {1}"| awk '{print $1}'| xargz nvim
             }

             nix-run() {
               local binary
               binary=$(nix-locate -w "bin/*"| rg -v 'man|share' | fzf | awk '{print $1}') [-n "$binary"] && nix run "$binary"
             }

             nix-lib() {
               nix-locate -w "$1"| fzf
             }

             nix-grep() {
               rg --files-with-matches --no-heading --line-number "$1" ~/flakes/modules/nixosModules ~/flakes/modules/homeManagerModules | fzf --preview="bat --color=always --style=numbers --line-range=:100 {}"
             }

             nix-find() {
               nix-locate -w "bin/*$1*"| fzf
             }

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
             export EDITOR=hx
             export VISUAL=hx
             export PATH=$HOME/.cargo/bin:$PATH
             export ZSH_CUSTOM=/nix/store/0ajaww0dwlfj6sd9drslzjpw2grhv177-oh-my-zsh-2024-10-01/share/oh-my-zsh/plugins
             export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
             export FZF_DEFAULT_OPTS='-i --height=50%'
             # export HELIX_RUNTIME=~/src/helix/runtime
    '';
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${host} /home/${username}/flakes";
      ft = "nh os test --hostname ${host} /home/${username}/flakes"; # dont save generation to boot menu
      fu = "nh os switch --hostname ${host} --update /home/${username}/flakes";
      upd = "sudo nixos-rebuild switch --upgrade --flake /home/${username}/flakes";
      rebuild = "/home/jr/scripts/performance_hook.sh";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      opts = "man home-configuration.nix";
      zd = "zeditor";
      lg = "lazygit";
      ip = "ip -color";
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      egrep = "grep -E --color=auto";
      fgrep = "grep -F --color=auto";
      nv = "cd ~/flakes && nix run .";
      grep = "grep --color=auto";
      vdir = "vdir --color=auto";
      dir = "dir --color=auto";
      v = "nvim";
      vz = "NVIM_APPNAME='lazy' nvim";
      vk = "NVIM_APPNAME='kick' nvim";
      vc = "nix run /home/jr/flakes/modules/nixCats";
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
      y = "yazi";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      keys = "ghostty +list-keybinds";
      cr = "cargo run";
      cb = "cargo build";
      ct = "cargo test";
      cc = "cargo check";
      rr = "rustc";
      rc = "rustc --explain";
      cn = "cargo new";
      cC = "cargo clippy";
      cP = "cargo clippy -- -W clippy::all -W clippy::pedantic";
      cf = "cargo rustfmt";
      repl = "evcxr";
    };
  };
}
