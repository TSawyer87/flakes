{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.nix-inspect.packages.${pkgs.system}.default # util for inspecting derivations
    cheat # Display cheat sheets for commands
    nitch
    inxi # show detailed system info
    wget
    eza
    efibootmgr # manage EFI boot entries
    inotify-tools # utility for monitoring file system events
    unrar # tool to extract RAR archives
    duf # Disk usage/free utility
    ncdu # Disk usage analyzer
    pciutils # Inspect PCI devices
    socat # multipurpose relay tool
    ripgrep
    lshw # display detailed hardware info
    nix-prefetch-git
    nix-prefetch-github
    tree
    cachix
    dconf2nix # util to generate Nix code from dconf settings
    dmidecode # tool to retrieve system hardware info from BIOS
    _7zz # tool for 7z archives
    p7zip
    alsa-utils # util for ALSA sound
    nix-diff # tool to compare derivations
    linuxKernel.packages.linux_zen.cpupower
    just
    unzip
    meson
    ninja
    gcc
    libgcc
    gnumake
    cmake
    openssl # toolkit for TLS/SSL
    pkg-config
  ];
}
