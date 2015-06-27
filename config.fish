set fish_greeting ""

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
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'

# Status Chars
set -g __fish_git_prompt_char_stagedstate '-'
set -g __fish_git_prompt_char_dirtystate '!'
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "x"
set -g __fish_git_prompt_char_cleanstate " "
set -g __fish_git_prompt_char_upstream_ahead '↑'
set -g __fish_git_prompt_char_upstream_behind '↓'
set -g __fish_git_prompt_char_stashstate '_'
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_error
set -g __fish_git_prompt_color_cleanstate green bold

# aliases
alias vi='vim'
alias l='ls -lA'
alias ll='ls -lAh'
alias dir='ls -lht | less'
alias b='bundle exec'

# env
set -x EDITOR vim
# go
setenv GOPATH $HOME/lab/go
set -gx PATH $GOTPATH/bin $PATH

# keybindings
function fish_user_key_bindings
  bind \cr history-search-backward
end

# ssh
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

# rbenv
set -gx PATH $HOME/.rbenv/bin $PATH
set -gx PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
status --is-interactive; and . (rbenv init -|psub)

# heroku
set -gx PATH /usr/local/heroku/bin $PATH

# java/android dev
set -gx JAVA_HOME /usr/lib/jvm/java-7-openjdk
set -gx _JAVA_AWT_WM_NONREPARENTING 1

function colored_path
  pwd | sed "s,/,$c0/$c1,g" | sed "s,\(.*\)/[^m]*m,\1/$c4,"
end

function fish_prompt
  # npm
  if test -d (npm bin)
    set -gx PATH (npm bin) $PATH
  end

  set -l last_status $status

  printf (colored_path)
  set_color normal
  if test -d .git
    printf (echo (__fish_git_prompt) | sed "s/[()|]//g")
  end

  if not test $last_status -eq 0
    set_color red
  end
  printf "> "
end

# dev helpers
function start_mysql
  sudo systemctl start mysqld
  ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock
end

