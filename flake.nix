{
  description = "MyFlake";

  inputs = {
    nixpkgs.url =
      "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nix-index-database.url = "github:nix-community/nix-index-database";
    # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # nixvim.url = "github:nix-community/nixvim";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    flake-utils.url = "github:numtide/flake-utils";
    # grub2-themes.url = "github:vinceliuice/grub2-themes";
    # grub2-themes.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs:
    let
      inherit (self) outputs;

      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      host = "magic";
      username = "jr";
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Import overlays explicitly
      overlays = import ./overlays { inherit inputs; };
    in
    {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays = overlays; # Export the overlays attribute set

      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit systems;
            inherit inputs;
            inherit username;
            inherit host;
            inherit outputs;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
                inherit systems;
                inherit outputs; # Ensure outputs is passed for overlays
              };
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./hosts/${host}/home.nix;
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
      };
    };
}
