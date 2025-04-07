{
  systemSettings,
  pkgs,
  ...
}: {
  home.file.".jj/config.toml".text = ''
    [ui]
    diff-editor = ["nvim", "-c", "DiffEditor $left $right $output"]
  '';
  home.packages = with pkgs; [
    lazyjj
    meld
  ];
  programs = {
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = systemSettings.gitEmail;
          name = systemSettings.gitUsername;
        };
        ui = {
          default-command = ["status" "--no-pager"];
          diff-editor = ":builtin";
          merge-editor = ":builtin";
        };
      };
    };
  };
}
