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
* zed
* urxvt / xorg
* tmux
* fish
* zsh
* alacritty
* ghostty
* wezterm
* warp
* qutebrowser
* julia
* and many more things, check out the top-level folders of this repo `ls -lA`

These dotfiles use `stow` to setup everything.

To make this work seamlessly, clone this repo in a directory in your home directory, so that it will for example end up in `/home/you/dotfiles`.

So, for example:

```sh
cd
git clone https://github.com/oem/dotfiles.git
```

Then run stow on the configs you are interested in:

```sh
stow neovim
stow tmux
```

or all, like this:

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

A little more work is required: I am using Chemacs2 as an emacs bootloader so that I can quickly switch between different emacs configurations (doom and my handrolled one in this case).

So you will need to also clone Chemacs:

```
mkdir .emacs.gnu
git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
stow emacs
```

If you also want doom emacs to be able to switch between the two configurations:

```
git clone https://github.com/hlissner/doom-emacs ~/doom-emacs
~/doom-emacs/bin/doom install
```

But for more information on Doom Emacs I would kindly like to point you to their very good documentation: [Doom Emacs: Getting Started](https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org)

`init.el` will want to load an `accounts.el` file which contains account-specific email settings. You can just remove that load statement or adjust it to your needs.

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

### kitty

`stow kitty`

### qutebrowser

`stow qutebrowser`

### haskell

`stow haskell`

### julia

`stow julia`

### Clipboards

tmux and vim use CLIPBOARD. Middle button in tmux will paste from CLIPBOARD.
In case you want to paste from UNNAMED (selected via mouse) use SHIFT middle mouse.
