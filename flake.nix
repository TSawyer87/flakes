{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "github:nix-community/nixvim";
    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-inspect.url = "github:bluskript/nix-inspect";
    # wezterm.url = "github:wez/wezterm?dir=nix";
    #zen-browser.url = "github:MarceColl/zen-browser-flake";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    { self, nixpkgs, nix-formatter-pack, home-manager, nvf, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "magic";
      username = "jr";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = {
        nvf = (nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ./nvf-configuration.nix ];
        }).neovim;
      };
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
            {
              # Apply the overlays to the NixOS system
              # nixpkgs.overlays = overlays;
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
            }
          ];
        };
      };

      # Add the formatter configuration
      formatter.${system} = nix-formatter-pack.lib.mkFormatter {
        inherit nixpkgs;
        inherit system;
        config = {
          tools = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        };
      };
      defaultPackage.${system} = self.packages.${system}.nvf;
    };
}
