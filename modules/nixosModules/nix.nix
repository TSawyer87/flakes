{
  lib,
  nixpkgs,
  ...
}: {
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };
}
