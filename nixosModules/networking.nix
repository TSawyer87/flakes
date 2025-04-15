{
  host,
  options,
  ...
}: {
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers =
    options.networking.timeServers.default
    ++ ["pool.ntp.org"];
}
