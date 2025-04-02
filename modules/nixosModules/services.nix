{ pkgs, systemSettings, username, ... }:
{
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = systemSettings.keyboardLayout;
        variant = "us";
      };
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = false;
    # printing = {
    #   enable = true;
    #   # drivers = [pkgs.hplipWithPlugin];
    # };
    gnome.gnome-keyring.enable = true;
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
    ipp-usb.enable = true;
    syncthing = {
      enable = false;
      user = systemSettings.username;
      dataDir = "/home/" + "${username}";
      configDir = "/home/" + "${username}" + "/.config/syncthing ";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # use pipewire
    pulseaudio.enable = false;
    psd = {
      enable = true;
      resyncTimer = " 1
        h ";
    };
    ollama = {
      enable = false;
      acceleration = "
        rocm ";
      environmentVariables = {
        HCC_AMDGPU_TARGET =
          "
        gfx1031 "; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = " 10.3 .1 ";
    };

    fwupd.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
    # bluetooth
    blueman.enable = true;
  };
}

