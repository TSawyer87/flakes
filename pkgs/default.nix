# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: wallpapers:
{
  wallpapers-package = pkgs.stdenv.mkDerivation {
    name = "wallpapers";
    src = wallpapers;
    installPhase = ''
      mkdir -p $out/share/wallpapers
      cp -r $src/* $out/share/wallpapers
    '';
  };
  show-wallpapers = pkgs.callPackage ./show-wallpapers.nix { wallpapers = ../wallpapers; };
}
