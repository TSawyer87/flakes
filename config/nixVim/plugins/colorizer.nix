{
  programs.nixvim = {
    plugins = {
      colorizer = {
        enable = true;

        lazyLoad.settings.cmd = "ColorizerToggle";
      };
    };
  };
}
