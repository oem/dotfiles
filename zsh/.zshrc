# zinit {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::brew

# completions
autoload -Uz compinit && compinit
zinit cdreplay -q
# }}}

# env {{{
export FZF_DEFAULT_COMMAND="fd --type f"
export GOPATH="$HOME/src/go"
export GOBIN="$GOPATH/bin"
export PYENV_ROOT="$HOME/.pyenv"
export EDITOR="nvim"
# }}}

# path {{{
path=("$HOME/.dotfiles/launch" $path)
path=("$HOME/.dotfiles/fuzzy" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.volta/bin" $path)
path=("$PYENV_ROOT/shims" $path)
path=($GOPATH $path)
path+=('/opt/homebrew/opt/llvm/bin')
export PATH
# }}}

# keybindings {{{
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

bindkey -s '^o' "as-session\n"
bindkey '^t' fzf_tmux
# }}}

 # history {{{
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
 # }}}

# completion styling {{{
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# }}}

# aliases {{{
alias vi='nvim'
alias v='nvim'
alias ex='emacs'
alias e='emacs -nw'
alias l='ls --color=never -lAh'
alias cat='bat -p'
alias dir='ls -lAht'
alias b='bundle exec'
alias c='cargo'
alias j='julia'
alias dc='docker compose'
# }}}

# shell integrations {{{
# homebrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
# }}}

# vim:fdm=marker
