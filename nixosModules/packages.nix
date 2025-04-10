{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    #cargo-watch
    #cargo-spellcheck
    alejandra
    keyd
    vimiv-qt
    qalculate-gtk
    wlroots
    evcxr # rust repl
    rustup
    killall
    libvirt
    lm_sensors
    libnotify
    v4l-utils
    ffmpeg
    virt-viewer # graphical consol client for qemu
    appimage-run
    chafa
    file-roller
    imv
    mpv
    # gimp
    greetd.tuigreet
    zig_0_12
    unipicker
    nvtopPackages.amd
    tradingview
    dconf-editor
    go
    transmission_4-gtk
  ];
}
