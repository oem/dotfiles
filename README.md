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
* julia

These dotfiles use stow to setup everything.

To make this work seamlessly, clone this repo in a directory in your home directory, so that it will for example end up in `/home/you/dotfiles`.

So, for example:

```
cd
git clone https://github.com/oem/dotfiles.git
```

Then run stow on all the configs you want, or all, like this:

`./install`

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

Btw: Try out this neat little nugget: tmux-leader o -> fuzzy search some directory you want to work on -> enter -> Boom! New tmux session with that directory set

### x11 stuff

`stow x11`

### alacritty

`stow alacritty`

### qutebrowser

`stow qutebrowser`

### julia

`stow julia`

### Clipboards

tmux and vim use CLIPBOARD. Middle button in tmux will paste from CLIPBOARD.
In case you want to paste from UNNAMED (selected via mouse) use SHIFT middle mouse.
