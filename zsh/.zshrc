# vim:fdm=marker

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
zinit snippet OMZP::ssh-agent

# completions
autoload -Uz compinit && compinit
zinit cdreplay -q
# }}}

# env {{{
export FZF_DEFAULT_COMMAND="fd --type f"
export GOPATH="$HOME/src/go"
export GOBIN="$GOPATH/bin"
export GOPROXY="proxy.golang.org"
export GOSUMDB="sum.golang.org"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export GOROOT=$(brew --prefix go)/libexec
else
    export GOROOT=$HOME/src/go
    export PATH=$PATH:$GOROOT/bin
fi

export PYENV_ROOT="$HOME/.pyenv"
export EDITOR="nvim"
export SSH_ENV="$HOME/.ssh/environment"

# Warp privacy settings
export WARP_ENABLE_TELEMETRY=0
export WARP_HONOR_PS1=1

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#000000,hl:#0080ff --color=fg+:#000000,bg+:#ffffff,hl+:#0080ff --color=info:#81fa00,prompt:#000000,pointer:#0080ff --color=marker:#81fa00,spinner:#ffffff,header:#ffffff'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
# }}}

# path {{{
path=("$HOME/.dotfiles/launch" $path)
path=("$HOME/.dotfiles/fuzzy" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.volta/bin" $path)
path=("$PYENV_ROOT/shims" $path)
path=("$PYENV_ROOT/bin" $path)
path=("$GOROOT/bin" $path)
path=($GOPATH $path)
path=($GOBIN $path)
path=("$HOME/.ghcup/bin" $path)
path=("$HOME/.cabal/bin" $path)
path=("$HOME/.local/share/nvim/mason/bin", $path)
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

# shell integrations {{{
# homebrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# yazi
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

if [ -e /home/deck/.nix-profile/etc/profile.d/nix.sh ]; then . /home/deck/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
# fnm
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"
# }}}

if [[ -f "$HOME/.local/bin/env" ]] then
    . "$HOME/.local/bin/env"
fi

[ -f "/home/oem/.ghcup/env" ] && . "/home/oem/.ghcup/env" # ghcup-env

# carapace: autocomplete suggestions for commands
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace chmod zsh)
