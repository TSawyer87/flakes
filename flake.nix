{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nix-index-database.url = "github:nix-community/nix-index-database";
    # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # nixvim.url = "github:nix-community/nixvim";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
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
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    wallpapers = {
      url = "git+ssh://git@github.com/TSawyer87/wallpapers.git";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    host = "magic";
    username = "jr";
    email = "sawyerjr.25@gmail.com";
    systemSettings = system: {
      # Make systemSettings a function of 'system'
      system = system;
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
  in rec {
    defaultPackage.${builtins.currentSystem} = self.packages.${builtins.currentSystem}.hello; # Example default package

    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        name = "nixos-dev";
        packages = with pkgs; [
          deadnix
          alejandra
          helix
          nix-diff
          nixfmt
          nix-tree
          nix-repl
          nix-store-tools
          ripgrep
          jq
          tree
          git
        ];

        shellHook = ''
          echo "Welcome to the NixOS development shell on $system!"
          echo "Tools available: deadnix, alejandra, helix, nix-diff, nixfmt, nix-tree, nix-repl, nix-store-tools, grep, jq, tree, git"
        '';
      };
    }) (flake-utils.lib.eachDefaultSystem (system: let pkgs = import nixpkgs {inherit system;}; in pkgs));

    packages = builtins.mapAttrs (system: pkgs: {
      hello = pkgs.hello; # Example package
      # Add other packages here
    }) (flake-utils.lib.eachDefaultSystem (system: let pkgs = import nixpkgs {inherit system;}; in pkgs));

    formatter =
      builtins.mapAttrs (system: pkgs: pkgs.alejandra)
      (flake-utils.lib.eachDefaultSystem (system: let pkgs = import nixpkgs {inherit system;}; in pkgs));

    nixosConfigurations."${host}" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Hardcode system here as it's a NixOS config
      specialArgs = {
        inherit inputs;
        inherit username;
        inherit host;
        inherit email;
        inherit (systemSettings "x86_64-linux") systemSettings; # Use the function
      };
      modules = [
        ./hosts/${host}/config.nix
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        # nix-index-database.nixosModules.nix-index
        # {programs.nix-index-database.comma.enable = true;}
        {
          home-manager.extraSpecialArgs = {
            inherit username;
            inherit inputs;
            inherit host;
            inherit (systemSettings "x86_64-linux") systemSettings; # Use the function
            inherit email;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."${username}" = import ./hosts/${host}/home.nix;
        }
      ];
    };
  };
}
