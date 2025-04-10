{lib, ...}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      # Number of simultaneous derivation builds
      max-jobs = lib.mkDefault 8;

      # Number of cores per derivation build
      cores = lib.mkDefault 0; # 0 means "use all available cores"
    };
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 4d";
    # };
  };
}
