{lib, ...}: {
  qt = {
    enable = true;
    # style.name = "adwaita-dark";
    style.name = "kvantum";
    platformTheme.name = lib.mkDefault "gtk3";
  };
}
