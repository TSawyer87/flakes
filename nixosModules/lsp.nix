{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    marksman
    markdown-oxide
    markdownlint-cli
    markdownlint-cli2
    nodePackages.prettier
    prettierd
    shfmt
    shellcheck
    nixd
    nodejs_22
    nil
    lua-language-server
    bash-language-server
    stylua
    jq
    taplo
    nixfmt-rfc-style
  ];
}
