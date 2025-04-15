{
  pkgs,
  host,
  options,
  ...
}: {
  environment.systemPackages = [pkgs.impala];
  # Enable networking
  networking = {
    # networkmanager.enable = true;
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
    networkmanager.wifi.backend = "iwd";
    hostName = "${host}";
    firewall = {
      enable = true;
      # allowedTCPPorts = [80 443 25];
      # allowedUDPPorts = [53 22];
    };
    # enableIPv6 = true;
    timeServers =
      options.networking.timeServers.default
      ++ ["pool.ntp.org"];
  };
}
