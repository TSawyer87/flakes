{ pkgs, ... }: {
  programs = {
    thunderbird.enable = true;
    yazi = { enable = true; };
    firefox.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = { symbol = " "; };
        c = { symbol = " "; };
        directory = { read_only = " 󰌾"; };
        docker_context = { symbol = " "; };
        fossil_branch = { symbol = " "; };
        git_branch = { symbol = " "; };
        golang = { symbol = " "; };
        hg_branch = { symbol = " "; };
        hostname = { ssh_symbol = " "; };
        lua = { symbol = " "; };
        memory_usage = { symbol = "󰍛 "; };
        meson = { symbol = "󰔷 "; };
        nim = { symbol = "󰆥 "; };
        nix_shell = { symbol = " "; };
        nodejs = { symbol = " "; };
        ocaml = { symbol = " "; };
        package = { symbol = "󰏗 "; };
        python = { symbol = " "; };
        rust = { symbol = " "; };
        swift = { symbol = " "; };
        zig = { symbol = " "; };
      };
    };
    # dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    steam = {
      enable = false;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };

}
