{ pkgs, inputs, ... }: {
  programs = {
    nushell = {
      enable = true;
      package = inputs.nushell-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # environmentVariables = {
      #   PAGER = "bat";
      #   EDITOR = "hx";
      #   VISUAL = "hx";
      # };

      configFile.source = ./nushell/config.nu;
      envFile.source = ./nushell/env.nu;
    };
    # Completions
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    # starship = {
    #   enable = false;
    #   enableNushellIntegration = true;
    # };
  };
}
