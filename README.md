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
* urxvt
* tmux
* fish

### neovim

Setup is all in lua, making startup lightning fast (with the help of packer's async loading).

Simply symlink the nvim directory to `~/.config/nvim`.

You might need to delete `~/.local/share/nvim/site` if you already had something in there and are getting weird lua errors when running `PackerInstall`.

There is also the old setup, which would also work with vim. The configuration for that is located in `vimrc` and `vim`.
