{
  programs.nixvim = {
    plugins.dressing = {
      enable = true;
      settings = {
        input = {
          enabled = true;
          mappings = {
            i = {
              "<C-c>" = "Close";
              "<CR>" = "Confirm";
              "<Down>" = "HistoryNext";
              "<Up>" = "HistoryPrev";
            };
            n = {
              "<CR>" = "Confirm";
              "<Esc>" = "Close";
            };
          };
        };
        select = {
          backend = ["telescope" "fzf_lua" "fzf" "builtin" "nui"];
          builtin = {
            mappings = {
              "<C-c>" = "Close";
              "<CR>" = "Confirm";
              "<Esc>" = "Close";
            };
          };
          enabled = true;
        };
      };
    };
  };
}
