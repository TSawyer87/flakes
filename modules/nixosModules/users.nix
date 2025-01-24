{ pkgs, username, lib, config, ... }:

let inherit (import ../../hosts/magic/variables.nix) gitUsername;
in {
  options = { users.enable = lib.mkEnableOption "Enables users module"; };

  config = lib.mkIf config.users.enable {
    users.users = {
      "${username}" = {
        homeMode = "755";
        isNormalUser = true;
        description = "${gitUsername}";
        hashedPassword =
          "$6$hLxz1nh01PVcUQ6e$4o6tYrRxbRQQFRN3NSUMkPuwdRpOhNdp1s07TAYr2shcbdQUkYurHyk8Xp8FvjVPwr60N4NSPDmwUr6Nd5FD9.";
        extraGroups =
          [ "networkmanager" "wheel" "libvirtd" "scanner" "lp" "root" "jr" ];
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
        packages = with pkgs; [ tealdeer zoxide mcfly tokei ];
      };
      # "newuser" = {
      #   homeMode = "755";
      #   isNormalUser = true;
      #   description = "New user account";
      #   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      #   shell = pkgs.bash;
      #   ignoreShellProgramCheck = true;
      #   packages = with pkgs; [];
      # };
    };
  };
}

