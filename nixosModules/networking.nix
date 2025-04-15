{
  host,
  options,
  ...
}: {
  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    firewall = {
      enable = true;
      # allowedTCPPorts = [80 443 25];
      # allowedUDPPorts = [53 22];
    };
    enableIPv6 = true;
    timeServers =
      options.networking.timeServers.default
      ++ ["pool.ntp.org"];
  };
}
