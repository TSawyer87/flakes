{ ... }:
let
  inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in
{
  programs = {
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
        ac = "!git add -A && git commit -m ";
      };
      ignores = [
        "*.jj"
        "/target"
      ];
    };
  };
}
