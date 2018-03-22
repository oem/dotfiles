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

# Fish git prompt
# set -g __fish_git_prompt_show_informative_status 1
# set -g __fish_git_prompt_hide_untrackedfiles 1
#
# set -g __fish_git_prompt_color_branch magenta
# set -g __fish_git_prompt_showupstream "informative"
# set -g __fish_git_prompt_showdirtystate 'yes'
# set -g __fish_git_prompt_showstashstate 'yes'
#
# # Status Chars
# set -g __fish_git_prompt_char_stagedstate '-'
# set -g __fish_git_prompt_char_dirtystate '!'
# set -g __fish_git_prompt_char_untrackedfiles "…"
# set -g __fish_git_prompt_char_conflictedstate "x"
# set -g __fish_git_prompt_char_cleanstate " "
# set -g __fish_git_prompt_char_upstream_ahead '↑'
# set -g __fish_git_prompt_char_upstream_behind '↓'
# set -g __fish_git_prompt_char_stashstate '_'
# set -g __fish_git_prompt_char_upstream_prefix ""
#
# set -g __fish_git_prompt_color_dirtystate blue
# set -g __fish_git_prompt_color_stagedstate yellow
# set -g __fish_git_prompt_color_invalidstate red
# set -g __fish_git_prompt_color_untrackedfiles $fish_color_error
# set -g __fish_git_prompt_color_cleanstate green
# }}}
# aliases {{{
alias vi='nvim'
alias l='exa -la'
alias ll='exa -lah'
alias dir='ls -lht | less'
alias b='bundle exec'
# alias code='code-insiders'
# }}}
# env {{{
set -x EDITOR nvim
set -gx PATH $HOME/dotfiles/launch $PATH
set -gx PATH $HOME/dotfiles/fuzzy $PATH
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx JAVA_HOME (/usr/libexec/java_home)
# }}}
# keybindings {{{
function fish_user_key_bindings
  # bind \cr history-search-backward
  bind \cr __fzf_ctrl_r
  bind \cf __fzf_ctrl_f
end
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

# if [ -n "$SSH_AGENT_PID" ]
#     ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
#     if [ $status -eq 0 ]
#         test_identities
#     end
# else
#     if [ -f $SSH_ENV ]
#         . $SSH_ENV > /dev/null
#     end
#     ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
#     if [ $status -eq 0 ]
#         test_identities
#     else
#         start_agent
#     end
# end
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
# rust {{{
# racer
set -gx PATH $HOME/.cargo/bin $PATH
set -x RUST_SRC_PATH $HOME/src/rust/src
# }}}
# mysql {{{
function start_mysql
  sudo systemctl start mysqld
  ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock
end
# }}}
# fzf {{{
set -U FZF_TMUX 0
function __fzfescape
  while read item
    echo -n (echo -n "$item" | sed -E 's/([ "$~'\''([{<>})&])/\\\\\\1/g')' '
  end
end

function __fzfcmd
  set -q FZF_TMUX; or set -l FZF_TMUX 0
  if test "$FZF_TMUX" -eq 1
    set -q FZF_TMUX_HEIGHT; or set -l FZF_TMUX_HEIGHT 40%
    fzf-tmux -d$FZF_TMUX_HEIGHT $argv
  else
    fzf $argv
  end
end

function __fzf_ctrl_r
    if not type -q fzf
        printf "fzf not yet installed. Installing now, please wait..."
        __fzf_install
        commandline -f repaint
        __fzf_ctrl_r
    else
        history | __fzfcmd +s +m --tiebreak=index --toggle-sort=ctrl-r | read -l select

        and commandline -rb $select
        commandline -f repaint
    end
end

function __fzf_ctrl_f
    if not type -q fzf
        printf "fzf not yet installed. Installing now, please wait..."
        __fzf_install
        commandline -f repaint
        __fzf_ctrl_t
    else
        set -q FZF_CTRL_T_COMMAND
        or set -l FZF_CTRL_T_COMMAND "
    command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
        eval "$FZF_CTRL_T_COMMAND" | __fzfcmd -m | __fzfescape | read -l selects
        and commandline -i "$selects"
        commandline -f repaint
    end
end

function z
    if set -q argv[1]
        set searchdir $argv[1]
    else
        set searchdir $HOME
    end

    # https://github.com/fish-shell/fish-shell/issues/1362
    set -l tmpfile (mktemp)
    find $searchdir \( ! -regex '.*/\..*' \) ! -name __pycache__ -type d | fzf > $tmpfile
    set -l destdir (cat $tmpfile)
    rm -f $tmpfile

    if test -z "$destdir"
        return 1
    end

    cd $destdir
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
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)
# }}}
#{{{ rbenv
status --is-interactive; and source (rbenv init -|psub)
#}}}


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/oem/src/njiuko/comdirect_alexa/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/oem/src/njiuko/comdirect_alexa/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/oem/src/njiuko/comdirect_alexa/node_modules/tabtab/.completions/sls.fish ]; and . /Users/oem/src/njiuko/comdirect_alexa/node_modules/tabtab/.completions/sls.fish
