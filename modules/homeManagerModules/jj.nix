{ ... }:
let inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in {
  home.file.".jj/config.toml".text = ''
    [ui]
    diff-editor = ["nvim", "-c", "DiffEditor $left $right $output"]
  '';
  programs = {
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "${gitUsername}";
          name = "${gitEmail}";
        };
        ui = {
          default-command = [ "status" "--no-pager" ];
          diff-editor = ":builtin";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
