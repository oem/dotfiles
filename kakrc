source "%val{config}/plugins/plug.kak/rc/plug.kak"

# fuzzy
plug "andreyorst/fzf.kak" depth-sort
map global normal <c-f> ': fzf-mode<ret>'
set global ui_options ncurses_assistant=cat

# fd instead of esc
hook global InsertChar d %{ try %{
      exec -draft hH <a-k>fd<ret> d
        exec <esc>
}}

# define commands to allow splitting with tmux
define-command -docstring "vsplit [<commands>]: split tmux vertically" \
vsplit -params .. -command-completion %{
        tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command -docstring "split [<commands>]: split tmux horizontally" \
split -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

alias global vs vsplit
alias global sp split
