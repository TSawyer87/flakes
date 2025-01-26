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
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    stylix.url = "github:danth/stylix";
  };

  outputs = { ... }@inputs:
    let
      system = "x86_64-linux";
      host = "magic";
      username = "jr";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkConfig = import ./lib/mkConfig.nix { inherit inputs pkgs system; };

      defaultConfig = mkConfig {
        userConfig = import ./hosts/${host}/config.nix;
        extraInputs = { };
      };
    in {
      # Main config builder
      lib = { inherit mkConfig; };
      nixosConfigurations.nixos = defaultConfig.nixosConfiguration;
      nixosConfigurations.${defaultConfig.userConfig.host} =
        defaultConfig.nixosConfiguration;

      packages.${system} = {
        # generate-config script
        gen-config = pkgs.writeShellScriptBin "gen-config"
          (builtins.readFile ./lib/gen-config.sh);

        # defaults to nix-vm
        default = defaultConfig.nix-vm.config.system.build.vm;

        # NixOS activation packages
        hydenix = defaultConfig.nixosConfiguration.config.system.build.toplevel;

        # Home activation packages
        hm =
          defaultConfig.homeConfigurations.${defaultConfig.userConfig.username}.activationPackage;
        hm-generic =
          defaultConfig.homeConfigurations."${defaultConfig.userConfig.username}-generic".activationPackage;

        # EXPERIMENTAL VM BUILDERS
        arch-vm = defaultConfig.arch-vm;
        fedora-vm = defaultConfig.fedora-vm;

        # Add the ISO builder
        iso = defaultConfig.installer.iso;
        burn-iso = defaultConfig.installer.burn-iso;
      };

      devShells.${system}.default =
        import ./lib/dev-shell.nix { inherit pkgs; };
    };
}
