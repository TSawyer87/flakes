{ pkgs
, lib
, ...
}: {
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      configFile.source = ./nushell/config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        zoxide init nushell | save -f ~/.zoxide.nu
        mkdir ~/.local/share/atuin/
        atuin init nu | save ~/.local/share/atuin/init.nu
        mkdir ~/.cache/carapace
        carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

        let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
        }
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true 
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100 
             completer: $carapace_completer # check 'carapace_completer' 
           }
         }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        # prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        h = "hx";
        c = "clear";
        fr = "nh os switch --hostname magic /home/jr/flakes";
        ft = "nh os test --hostname magic /home/jr/flakes";
        fu = "nh os switch --hostname magic --update /home/jr/flakes";
        zd = "zeditor";
        lg = "lazygit";
        tarnow = "tar -acf";
        untar = "tar -zxvf";
        opts = "man home-configuration.nix";
        # ncg =
        #   "nix-collect-garbage --delete-old ; sudo nix-collect-garbage -d ; sudo /run/current-system/bin/switch-to-configuration boot";
        y = "yazi";
        repl = "evcxr";
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
        fz = "fzf --bind 'enter:become(hx {})'";

      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
