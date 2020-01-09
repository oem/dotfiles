#!/bin/sh

# xorg
if [ ! "$(uname)" = "Darwin" ]; then
[ ! -L ~/.xinitrc ] && ln -s ~/dotfiles/xinitrc ~/.xinitrc
[ ! -L ~/.Xdefaults ] && ln -s ~/dotfiles/Xdefaults ~/.Xdefaults
[ ! -L ~/.xmodmap ] && ln -s ~/dotfiles/xmodmap ~/.xmodmap
fi

# alacritty
[ ! -d ~/.config/alacritty ] && mkdir -p ~/.config/alacritty
[ ! -L ~/.config/alacritty/alacritty.yml ]  && ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

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
[ ! -L ~/.pylintrc ] && ln -s ~/dotfiles/.pylintrc ~/.pylintrc

# ranger
[ ! -L ~/.config/ranger/rc.conf ] && ln -s ~/dotfiles/rc.conf ~/.config/ranger/rc.conf

# kakoune
[ ! -d ~/.config/kak ] && mkdir -p ~/.config/kak/{plugins,autoload}
[ ! -L ~/.config/kak/kakrc ] && ln -s ~/dotfiles/kakrc ~/.config/kak/kakrc
[ ! -d ~/.config/kak/plugins/plug.kak ] && git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak
