{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    systems.url = "github:nix-systems/x86_64-linux";
    impermanence.url = "github:nix-community/impermanence/master";
    dont-track-me.url = "github:dtomvan/dont-track-me.nix/main";
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
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

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

    pkgs = import nixpkgs {
      inherit systems;
      config.allowUnfree = true; # Optional, if you need unfree packages
      # overlays = [inputs.neovim-nightly-overlay.overlays.default]; # Add neovim overlay
    };

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Dev Shell for x86_64-linux
    devShells.${systems}.default = pkgs.mkShell {
      name = "nixos-dev";
      packages = with pkgs; [
        deadnix
        alejandra
        helix
        nix-diff
        nixfmt-rfc-style
        nix-tree
        ripgrep
        jq
        tree
        git
        nh
        nixd
        nil
      ];

      shellHook = ''
        echo "Welcome to the NixOS development shell!"
        echo "Tools available: deadnix, alejandra, helix, nix-diff, nixfmt, nix-tree, nix-store, ripgrep, jq, tree, git"
      '';
    };

    # Formatter for x86_64-linux
    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Optional: Packages (only if you need custom ones)
    # packages.${system} = {
    #   # Add custom packages here if needed
    # };

    # NixOS Configuration
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
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
}
