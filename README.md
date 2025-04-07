# Flakes Structure and Usage (Hyprland)

- This flake provides two NixOS configurations:

  - magic: A desktop configuration for AMD hardware. More recent updates.

  - laptop: A desktop configuration for Intel hardware.

**Customizing the Flake**

To personalize this flake for your system, follow these steps:

1. In the `~/flake/hosts/<hostname>/` directory run:

```bash
sudo nixos-generate-config --show-hardware-config > hardware.nix
```

- If the above command fails, I've found that `nh` picks up everything better
  initially. Also `nh` is what is used in the `fr` and `fu` aliases.

- You can use `nix-shell -p nh`, then run the command:

```nix
nh os switch --hostname ${host} /home/${username}/flakes
```

2. Rename the directory to your desired `<hostname>` and finally change the `flake.nix` file:

```nix
host = "your-hostname";
```

3. Finally, generate the flake with:

```bash
sudo nixos-rebuild switch --flake /home/<username>/flakes#<hostname>
```

- I am trying out mapping the ESC key to the CAPS key, if you don't like this remove the
  setting in `keyd.nix`. (makes it easier for modal editors)

## Keybinds

After your flake is initialized, a few aliases:

- `fr` = flake rebuild, # use this after making any changes to make them take effect and persist.

- `fu` = flake update, # updates the dependencies of your current flake project.

- `ncg` = Nix Collect Garbage

- `upd` = `sudo nixos-rebuild switch --upgrade`

- `Super+Return` = launch Ghostty terminal

- `Super+T` = launch Kitty terminal

- `Super+Shift+Return` = launch kitty dropdown scratchpad

- `Super+D` = rofi

- `Super` = wofi

- `Alt+Return` = Full Screen

- `Super+Alt+w`

- Click the top right keys for a cheatsheet that might be out of date

- `v`, `vi` = Neovim, I'm pretty happy with the config so far.

| Nvim Keybind         | Description                                         |
| -------------------- | --------------------------------------------------- |
| `leader`             | Space                                               |
| `leader + fm`        | conform format manual can be used to check nix code |
| `leader + j`         | Hop nvim navigation                                 |
| `leader + s`         | splits                                              |
| `leader+zm`          | Zen-Mode                                            |
| `Shift+ h`           | switch buffer left                                  |
| `Shift+ l`           | switch buffer right                                 |
| `-`                  | launch oil.nvim file browser                        |
| `Ctrl+;` or `Ctrl+y` | accept cmp or codeium                               |
| `Ctrl+ tik char`     | Launch toggleterm                                   |
| `Ctrl+/`             | Close toggleterm                                    |
| `zR`                 | open all folds (ufo)                                |
| `zM`                 | close all folds                                     |
| `s`                  | flash-nvim movement                                 |
| `leader + e`         | yazi-nvim file browser                              |
| `leader + ha`        | harpoon add                                         |

- `yz` = Yazi, terminal based file manager, uses `vim` bindings.

- `Ctrl-r` = Mcfly history search

- `tldr` = Tealdeer example-based docs.

- `z` = Zoxide

- `zd` = Zed-Editor (configured for Rust development)

- `vi` = Recently switched back to standard NixOS neovim, all the configs are there if you choose to use NixVim or NVF just uncomment one in the `home.nix`. Be aware of
  2 programs trying to use the same `vi` or `vim` aliases.

### Structure

- The main `config.nix` and `home.nix` files are located in the `~/flakes/hosts/${host}/` directory.

- In the `~/flakes/modules/nixosModules/` directory you can add packages, services, programs, and modules. If you add a module just make sure to add the module name to the
  `default.nix` in the directory. NixOS automatically searches for a `default.nix` in whichever directory you import to your `config.nix` or `home.nix` so all we have to import is
  the `nixosModules` directory and the `default.nix` bundles all of the files making less implicit import statements necessary.

- The same for home-manager, the modules imported into the `home.nix` are located in `~/flakes/modules/homeManagerModules/` you can add home packages, programs, and more there. Same
  applies here with the `default.nix`.

- I'm currently refactoring and placing most everything in the `modules` directory, you'll find the Hyprland and Sway configs there as well as text editors etc.

- I set my cursor with stylix so to change cursors the directory is `~/flakes/modules/nixosModules/stylix.nix`

### This flake is inspired by the ZaneyOS project:

[ZaneyOS Documentation](https://zaney.org/posts/zaneyos-2.2/)

For a more in-depth look at Flakes:

[Nix Flakes: an Introduction](https://xeiaso.net/blog/nix-flakes-1-2022-02-21/)

[Practical Nix Flakes](https://serokell.io/blog/practical-nix-flakes)

For NixLang docs:

[NixLang One Pager](https://github.com/tazjin/nix-1p)

[Learn Nix in Y Minutes](https://learnxinyminutes.com/nix/)

### Thank You for reading, please star the repo if you found it useful!

### Sway WM

- You can switch between Sway and Hyprland by adding a comment to one and
  uncommenting the other in the `~/flakes/hosts/{host}/home.nix`. You'll also
  have to switch the setting for greetd which can be uncommented in the
  `~/flakes/modules/nixosModules/default.nix`. Lastly uncomment the `pkgs.xdg-desktop-portal-hyprland`
  in the `~/flakes/modules/nixosModules/xdg.nix` file.

| Keybind      | Description             |
| ------------ | ----------------------- |
| `Mod+f`      | Launch Firefox          |
| `Mod+Return` | Launch Ghostty          |
| `Mod+T`      | Launch Kitty            |
| `y`          | Yazi                    |
| `Mod+Space`  | Launch wofi drun        |
| `Mod+d`      | Launch rofi             |
| `Mod+g`      | Split h                 |
| `Mod+z`      | Split v                 |
| `Mod+v`      | Cliphist history        |
| `Mod+n`      | Thunar                  |
| `Mod+c`      | cliphist history        |
| `Mod+s`      | screenshot area         |
| `Mod+p`      | launch list of commands |
