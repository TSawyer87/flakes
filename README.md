# Flakes Structure and Usage

-   This flake provides two NixOS configurations:

    -   magic: A desktop configuration for AMD hardware.

    -   laptop: A desktop configuration for Intel hardware.

**Customizing the Flake**

To personalize this flake for your system, follow these steps:

1. In the `~/flake/hosts/<hostname>/` directory run:

```bash
sudo nixos-generate-config --show-hardware-config > hardware.nix
```

2. Rename the directory to your desired `<hostname>` and finally change the `flake.nix` file:

```nix
host = "your-hostname";
```

3. Finally, generate the flake with:

```bash
sudo nixos-rebuild switch --flake /home/<username>/flakes#<hostname>
```

## Keybinds

After your flake is initialized, a few aliases:

-   `fr` = flake rebuild, # use this after making any changes to make them take effect and persist.

-   `fu` = flake update, # updates the dependencies of your current flake project.

-   `ncg` = Nix Collect Garbage

-   `Super+Return` = launch Wezterm

-   `v`, `vi` = Neovim, I'm pretty happy with the config so far.

-   `yz` = Yazi, terminal based file manager, uses `vim` bindings.

-   `Ctrl-r` = Mcfly history search

-   `tldr` = Tealdeer example-based docs.

-   `z` = Zoxide

-   `zed` = Zed-Editor

### This flake is inspired by the ZaneyOS project:

[ZaneyOS Documentation](https://zaney.org/posts/zaneyos-2.2/)

For a more in-depth look at Flakes:

[Nix Flakes: an Introduction](https://xeiaso.net/blog/nix-flakes-1-2022-02-21/)

[Practical Nix Flakes](https://serokell.io/blog/practical-nix-flakes)
For NixLang docs:

[NixLang One Pager](https://github.com/tazjin/nix-1p)

[Learn Nix in Y Minutes](https://learnxinyminutes.com/nix/)

### Thank You for reading, please star the repo if you found it useful!
