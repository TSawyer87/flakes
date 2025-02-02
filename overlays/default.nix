# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {
      # example = prev.example.overrideAttrs (oldAttrs: rec {
      # ...
      # });
    };

  rust-overlay = final: prev: {
    # Import the rust-overlay
    rustc = inputs.rust-overlay.packages.${prev.system}.default;
    cargo = inputs.rust-overlay.packages.${prev.system}.default;
    rustfmt = inputs.rust-overlay.packages.${prev.system}.default;
    clippy = inputs.rust-overlay.packages.${prev.system}.default;

    # If you want to use nightly specifically:
    rust-nightly = inputs.rust-overlay.packages.${prev.system}.rustChannelOf {
      # date = "2023-10-01"; # Example date, change or remove for latest nightly
      channel = "nightly";
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
