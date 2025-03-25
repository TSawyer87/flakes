{ ... }: {
  programs = {
    nushell = {
      enable = true;

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
