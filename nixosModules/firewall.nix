{...}: {
  # Open ports in the firewall.
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 80 443 25 ];
  # networking.firewall.allowedUDPPorts = [ 53 22 ];
  networking.enableIPv6 = true;
}
