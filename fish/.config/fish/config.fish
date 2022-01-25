# vim:fdm=marker

set fish_greeting ""
# colors {{{
# prompt colors
set fish_color_error ff8a00

# c0 to c4 progress from dark to bright
# ce is the error colour
set -g c0 (set_color 005284)
set -g c1 (set_color 0075cd)
set -g c2 (set_color 009eff)
set -g c3 (set_color 6dc7ff)
set -g c4 (set_color ffffff)
set -g ce (set_color $fish_color_error)
# }}}
# aliases {{{
alias vi='nvim'
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
# env {{{
set -x EDITOR nvim
set -gx PATH $HOME/.dotfiles/launch $PATH
set -gx PATH $HOME/.dotfiles/fuzzy $PATH
set -gx PATH $HOME/google-cloud-sdk/bin $PATH
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
# set -gx JAVA_HOME (/usr/libexec/java_home)
set -gx NODE_PATH "/usr/local/lib/node_modules"
set -gx N_PREFIX "/home/oem"
set -gx PATH $N_PREFIX/bin $PATH
set -gx FZF_DEFAULT_COMMAND "fd --type f"
# }}}
# keybindings {{{
# function fish_user_key_bindings
#   fzf_key_bindings
# end
bind \cw backward-kill-word
bind \co as-session
bind \ct fzf_tmux

# }}}
# ssh {{{
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
# }}}
# neovim {{{
set -x XDG_CONFIG_HOME $HOME/.config
# }}}
# go {{{
setenv GOPATH $HOME/src/go
set -x GOPATH $HOME/src/go
setenv GOBIN $GOPATH/bin
set -gx GOBIN $GOPATH/bin
set -gx PATH $GOBIN $PATH
# }}}
# lua {{{
set -gx PATH $HOME/.luarocks/bin $PATH
# }}}
# rust {{{
set -gx PATH $HOME/.cargo/bin $PATH
set -x RUST_SRC_PATH $HOME/src/rust/src
# }}}
# {{{ ruby
set -gx RBENV_ROOT $HOME/.rbenv
set -gx PATH $RBENV_ROOT/shims $PATH
# }}}
# swift {{{
# custom toolchains like tensowflow
set -gx PATH /Library/Developer/Toolchains/swift-latest/usr/bin $PATH
# }}}
# mysql {{{
function start_mysql
  sudo systemctl start mysqld
  ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock
end
# }}}
# fzf {{{
function kp --description "Kill processes"
  set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
  set -l __kp__kc $argv[1]

  if test "x$__kp__pid" != "x"
    if test "x$argv[1]" != "x"
      echo $__kp__pid | xargs kill $argv[1]
    else
      echo $__kp__pid | xargs kill -9
    end
    kp
  end
end

function bip --description "Install brew plugins"
  set -l inst (brew search | eval "fzf $FZF_DEFAULT_OPTS -m --header='[brew:install]'")

  if not test (count $inst) = 0
    for prog in $inst
      brew install "$prog"
    end
  end
end

function bup --description "Update brew plugins"
  set -l inst (brew leaves | eval "fzf $FZF_DEFAULT_OPTS -m --header='[brew:update]'")

  if not test (count $inst) = 0
    for prog in $inst
      brew upgrade "$prog"
    end
  end
end

function bcp --description "Remove brew plugins"
  set -l inst (brew leaves | eval "fzf $FZF_DEFAULT_OPTS -m --header='[brew:update]'")

  if not test (count $inst) = 0
    for prog in $inst
      brew uninstall "$prog"
    end
  end
end

function fp --description "Search your path"
  set -l loc (echo $PATH | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:path]'")

  if test (count $loc) = 1
    set -l cmd (rg --files -L $loc | rev | cut -d'/' -f1 | rev | tr ' ' '\n' | eval "fzf $FZF_DEFAULT_OPTS --header='[find:exe] => $loc'")
    if test (count $cmd) = 1
      echo $cmd
    else
      fp
    end
  end
end
# }}}
# {{{ posix
function posix-source
  for i in (cat $argv)
    set arr (echo $i |tr = \n)
    set -gx $arr[1] $arr[2]
  end
end
# }}}
# {{{ python
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/shims $PATH
set -gx PATH $HOME/.local/bin $PATH

status --is-interactive; and pyenv init - --no-rehash | source
# status --is-interactive; and pyenv virtualenv-init - | source
# }}}

starship init fish | source
set -g fish_user_paths "/usr/local/opt/binutils/bin" $fish_user_paths
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/oem/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/oem/.ghcup/bin $PATH
