{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    wezterm.url = "github:wez/wezterm?dir=nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    ghostty = { url = "github:ghostty-org/ghostty"; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    stylix.url = "github:danth/stylix";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, zen-browser
    , wezterm, hyprland-qtutils, ghostty, neovim-nightly-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "magic";
      username = "jr";

      # Define the overlay for pokemon-colorscripts
      pokemonColorscriptsOverlay = final: prev: {
        pokemon-colorscripts = import ./modules/pokemon-colorscripts.nix {
          pkgs = final;
          lib = final.lib;
        };
      };

      # Combine all overlays
      overlays =
        [ pokemonColorscriptsOverlay neovim-nightly-overlay.overlays.default ];
    in {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = overlays; # Apply all overlays here
              environment.systemPackages = with pkgs; [
                pokemon-colorscripts
                pkgs.neovim
              ];
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
                inherit system;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./hosts/${host}/home.nix;
            })
          ];
        };
      };

      homeConfigurations."${username}@${host}" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system}.extend
            (final: prev: final.lib.composeManyExtensions overlays);
          extraSpecialArgs = {
            inherit inputs;
            inherit host;
            inherit system;
            inherit username;
          };
          modules = [
            ({ pkgs, ... }: {
              home.packages = with pkgs; [
                pokemon-colorscripts
                pkgs.neovim # This will now use the nightly version
                nix-index-database.hmModules.nix-index
                # Other home-manager packages
              ];
            })
            ./hosts/${host}/home.nix
          ];
        };
    };
}

