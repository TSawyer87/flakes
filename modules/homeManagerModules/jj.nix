{ ... }:
let inherit (import ../../hosts/magic/variables.nix) gitUsername gitEmail;
in {
  programs = {
 jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "${gitUsername}";
          name = "${gitEmail}";
        };
      };
    };
  };
}
