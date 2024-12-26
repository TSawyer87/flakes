{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    wezterm.url = "github:wez/wezterm?dir=nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    ghostty = { url = "github:ghostty-org/ghostty"; };
    stylix.url = "github:danth/stylix";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, zen-browser, wezterm, hyprland-qtutils
    , ghostty, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "laptop";
      username = "jr";
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
            {
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
      homeConfigurations."${username}@${host}" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/${host}/home.nix ];
        };
    };
}
