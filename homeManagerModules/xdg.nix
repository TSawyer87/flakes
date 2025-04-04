{...}: {
  xdg = {
    # configFile."mimeapps.list".text = ''
    # [Default Applications]
    # x-scheme-handler/http=zen.desktop
    # x-scheme-handler/https=zen.desktop
    # text/html=zen.desktop
    # application/pdf=org.pwmt.zathura.desktop
    # '';
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
