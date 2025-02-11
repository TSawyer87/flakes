{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      rustaceanvim = {
        enable = true;
        settings = {
          dap = {
            autoloadConfigurations = true;
          };

          server = {
            # default_settings is usually for settings that apply to ALL servers
            # You don't need it if you're configuring a specific server like rust-analyzer
            # default_settings = { ... };  <- Remove this

            rust-analyzer = {  # <- Settings for rust-analyzer go directly here
              cargo = {
                buildScripts.enable = true;
                features = "all";
              };

              diagnostics = {
                enable = true;
                styleLints.enable = true;
              };

              checkOnSave = true;
              check = {
                command = "clippy";
                features = "all";
              };

              files = {
                excludeDirs = [
                  ".cargo"
                  ".direnv"
                  ".git"
                  "node_modules"
                  "target"
                ];
              };

              inlayHints = {
                bindingModeHints.enable = true;
                closureStyle = "rust_analyzer";
                closureReturnTypeHints.enable = "always";
                discriminantHints.enable = "always";
                expressionAdjustmentHints.enable = "always";
                implicitDrops.enable = true;
                lifetimeElisionHints.enable = "always";
                rangeExclusiveHints.enable = true;
              };

              procMacro = {
                enable = true;
              };

              rustc.source = "discover";
            }; # <- End of rust-analyzer settings
          }; # <- End of server settings
        }; # <- End of settings
      }; # <- End of rustaceanvim plugin
    }; # <- End of plugins
  }; # <- End of programs.nixvim
}
