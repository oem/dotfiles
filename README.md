```

  ███    ███   █████  ████  █  █     ████  ████
  █░░█  █░░░█  ░░█░░  █░░░  █  █     █░░░  ██░░
  █  █  █   █    █    ██    █  █     ██     ░██
  ███░  ░███░    █    █░    █  ████  ████  ████
  ░░░    ░░░     ░    ░     ░  ░░░░  ░░░░  ░░░░
```

## programs used and customized

* emacs
* neovim
* urxvt / xorg
* tmux
* fish
* alacritty
* qutebrowser

These dotfiles use stow to setup everything.

Note: There are plenty of files not managed by stow. Only the ones mentioned in the list above are. The rest is old stuff that will probably go away at some point.

### neovim

`stow neovim`

Setup is all in lua, making startup lightning fast (with the help of packer's async loading).

Run following commands in neovim:

```
:PackerInstall
:PackerCompile
```

Restart neovim.

You might need to delete `~/.local/share/nvim/site` if you already had something in there and are getting weird lua errors when running `PackerInstall`.

There is also the old setup, which would also work with vim. The configuration for that is located in `vimrc` and `vim`.

### emacs

`stow emacs`

### fish

`stow fish`

You might also want to install the fzf plugin for all the nice fuzzying:

`fisher install jethrokuan/fzf`

### tmux

`stow tmux`

### x11 stuff

`stow x11`

### alacritty

`stow alacritty`

### qutebrowser

`stow qutebrowser`

### Clipboards

tmux and vim use CLIPBOARD. Middle button in tmux will paste from CLIPBOARD.
In case you want to paste from UNNAMED (selected via mouse) use SHIFT middle mouse.
