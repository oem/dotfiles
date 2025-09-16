# vim:fdm=marker

# env {{{
export FZF_DEFAULT_COMMAND="fd --type f"
export GOPATH="$HOME/src/go"
export GOBIN="$GOPATH/bin"
export GOPROXY="proxy.golang.org"
export GOSUMDB="sum.golang.org"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export GOROOT=$(brew --prefix go)/libexec
else
    export GOROOT=/usr/lib/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

export PYENV_ROOT="$HOME/.pyenv"
export EDITOR="nvim"
export SSH_ENV="$HOME/.ssh/environment"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --no-color --black'
# }}}

# path {{{
PATH="$HOME/.dotfiles/launch:$PATH"
PATH="$HOME/.dotfiles/fuzzy:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.volta/bin:$PATH"
PATH="$PYENV_ROOT/shims:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$GOROOT/bin:$PATH"
PATH="$GOPATH:$PATH"
PATH="$GOBIN:$PATH"
PATH="$HOME/.ghcup/bin:$PATH"
PATH="$HOME/.cabal/bin:$PATH"
PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
PATH="$PATH:/opt/homebrew/opt/llvm/bin"
# }}}

# aliases {{{
alias vi='nvim'
alias v='nvim'
alias ex='emacs'
alias e='emacs -nw'
alias l='eza -l --icons --git -a --colour=never'
alias lt='eza --tree --level=2 --long --icons --git'
alias ll='ls --color=never -lAh'
alias cat='bat -p'
alias dir='ls -lAht'
alias b='bundle exec'
alias c='cargo'
alias dc='docker compose'
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
# }}}


# integrations with external tools {{{
eval "$(starship init bash)"
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
source <(carapace _carapace)
eval "$(zoxide init bash)"

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh

eval "$(fzf --bash)"
# }}}

# keybindings {{{
# }}}

