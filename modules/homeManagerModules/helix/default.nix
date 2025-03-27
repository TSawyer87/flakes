{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "kanagawa";
    };
    languages = {
      language = [
      {
        name = "rust";
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [ "marksman" ];
        formatter = {
          command = "prettier";
          args = [ "--stdin-filepath" "file.md" ];
        };
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = true;
        language-servers = [ "nil" ];
        formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
      }
      
      ];
    };
  };
}
