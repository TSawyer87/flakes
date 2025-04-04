{...}: {
  programs.fd = {
    enable = true;
    ignores = [
      ".git/"
      "*.bak"
      ".cache/"
    ];
  };
}
