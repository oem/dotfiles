#!/bin/sh

# xorg
[ ! -L ~/.xinitrc ] && ln -s ~/dotfiles/xinitrc ~/.xinitrc
[ ! -L ~/.Xdefaults ] && ln -s ~/dotfiles/Xdefaults ~/.Xdefaults
[ ! -L ~/.xmodmap ] && ln -s ~/dotfiles/xmodmap ~/.xmodmap

# fish
[ ! -d ~/.config/fish ] && mkdir -p ~/.config/fish
[ ! -L ~/.config/fish/config.fish ]  && ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
[ ! -L ~/.config/fish/fishfile ] && ln -s ~/dotfiles/fishfile ~/.config/fish/fishfile

# vim
[ ! -d ~/.config/nvim ] && mkdir ~/.config/nvim
[ ! -L ~/.config/nvim/init.vim ] && ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
[ ! -d ~/.local/share/nvim ] && mkdir -p ~/.local/share/nvim
[ ! -L ~/.local/share/nvim/site ] && ln -s ~/dotfiles/vim ~/.local/share/nvim/site

# tmux
[ ! -L ~/.tmux.conf ] && ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# git
[ ! -L ~/.gitconfig ] && ln -s ~/dotfiles/gitconfig ~/.gitconfig

# python
[ ! -L ~/.flake8 ] && ln -s ~/dotfiles/flake8 ~/.flake8

