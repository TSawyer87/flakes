{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # nixvim.url = "github:nix-community/nixvim";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    # systems.url = "github:nix-systems/default-linux";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    wallpapers = {
      url = "git+ssh://git@github.com/TSawyer87/wallpapers.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    yazi,
    nix-index-database,
    nvf,
    rose-pine-hyprcursor,
    wallpapers,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "magic";
    username = "jr";
    email = "sawyerjr.25@gmail.com";
    systemSettings = {
      system = "x86_64-linux";
      timezone = "America/New_York";
      locale = "en_US.UTF-8";
      gitUsername = "TSawyer87";
      gitEmail = "sawyerjr.25@gmail.com";
      dotfilesDir = "~/.dotfiles";
      wm = "hyprland";
      browser = "firefox";
      term = "ghostty";
      editor = "hx";
      keyboardLayout = "us";
    };
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
          inherit email;
          inherit systemSettings;
        };
        modules = [
          ./hosts/${host}/config.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index
          {programs.nix-index-database.comma.enable = true;}
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit inputs;
              inherit host;
              inherit system;
              inherit systemSettings;
              inherit email;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./hosts/${host}/home.nix;
          }
        ];
      };
    };
  };
}
