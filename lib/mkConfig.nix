{ inputs, pkgs, system, ... }:
{ userConfig, extraInputs ? { }, extraPkgs ? null, }: rec {
  # Simplified common arguments just for VM definitions
  commonArgs = {
    inherit system userConfig;
    pkgs = pkgs;
  };

  nix-vm = import ../hosts/vm/nix-vm.nix { inherit userConfig; };

  arch-vm = import ../hosts/vm/arch-vm.nix { inherit pkgs userConfig; };
}
