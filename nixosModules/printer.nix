{ pkgs, ... }: {
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    avahi = {
      # enables auto-discovery
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
