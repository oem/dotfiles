source "%val{config}/plugins/plug.kak/rc/plug.kak"

# fuzzy
map -docstring 'all file contents' global user / %{: fzf -kak-cmd %{evaluate-commands} -items-cmd %{rg --column --line-number --no-heading --color=never --smart-case ''} -filter %{sed -e 's/\([^:]*\):\([^:]*\):\([^:]*\):.*/edit -existing \1 \2 \3/'}<ret>}

plug "andreyorst/fzf.kak" config %{
    map global user d '<esc>:fzf-mode<ret>' -docstring "fzf all"
    map global user f '<esc>:fzf-mode<ret>f' -docstring "fzf"
    # map global user / '<esc>:fzf-mode<ret>g' -docstring "fzf search"
    map global user b '<esc>:fzf-mode<ret>b' -docstring "fzf buffer"
} defer "fzf" %{
    set-option global fzf_file_command 'fd'
    set-option global fzf_preview_tmux_height '20%'
    set-option global fzf_highlight_command 'bat'
}

set global ui_options ncurses_assistant=none

# fd instead of esc
hook global InsertChar d %{ try %{
      exec -draft hH <a-k>fd<ret> d
        exec <esc>
}}

# lsp
plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path .
} config %{
    set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
    set-option global lsp_diagnostic_line_error_sign "!"
    set-option global lsp_diagnostic_line_warning_sign "?"
    hook global WinSetOption filetype=(c|cpp|go|rust) %{
        map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
        lsp-enable-window
        lsp-auto-hover-enable
        lsp-auto-hover-insert-mode-disable
        set-option window lsp_hover_anchor true
        set-face window DiagnosticError default+u
        set-face window DiagnosticWarning default+u
    }
    hook global WinSetOption filetype=rust %{
        set-option window lsp_server_configuration rust.clippy_preference="on"
    }
    hook global KakEnd .* lsp-exit
}

# ui
addhl global/ wrap # wrap lines

# clipboard
plug "lePerdu/kakboard" %{
    hook global WinCreate .* %{ kakboard-enable }
}

# space is my leader
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

# comands to split via tmux but stay in the same session
define-command -docstring "vsplit [<commands>]: split tmux vertically" \
vsplit -params .. -command-completion %{
        tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}

define-command -docstring "split [<commands>]: split tmux horizontally" \
split -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

define-command -docstring "tabnew [<commands>]: opens new tmux window" \
tabnew -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}

alias global vs vsplit
alias global sp split

# switching to cli tools
def suspend-and-resume \
    -override \
    -params 1..2 \
    -docstring 'suspend-and-resume <cli command> [<kak command after resume>]' \
    %{ evaluate-commands %sh{

    nohup sh -c "sleep 0.01; osascript -e 'tell application \"System Events\" to keystroke \"$1 && fg\\n\" '" > /dev/null 2>&1 &
    /bin/kill -SIGTSTP $kak_client_pid
    if [ ! -z "$2" ]; then
        echo "$2"
    fi
}}

# ranger
def for-each-line \
    -docstring "for-each-line <command> <path to file>: run command with the value of each line in the file" \
    -params 2 \
    %{ evaluate-commands %sh{

    while read f; do
        printf "$1 $f\n"
    done < "$2"
}}

def toggle-ranger %{
    suspend-and-resume \
        "ranger --choosefiles=/tmp/ranger-files-%val{client_pid}" \
        "for-each-line edit /tmp/ranger-files-%val{client_pid}"
}

map global user r ': toggle-ranger<ret>' -docstring 'select files in ranger'


declare-user-mode tig
map global tig b ': tig-blame<ret>' -docstring 'show blame (with tig)'
map global tig s ': suspend-and-resume "tig status"<ret>' -docstring 'show git status (with tig)'
map global tig m ': suspend-and-resume "tig"<ret>' -docstring 'show main view (with tig)'

map global user t ': enter-user-mode tig<ret>' -docstring 'tig commands'

# tab completion
hook global InsertCompletionShow .* %{
    try %{
        # this command temporarily removes cursors preceded by whitespace;
        # if there are no cursors left, it raises an error, does not
        # continue to execute the mapping commands, and the error is eaten
        # by the `try` command so no warning appears.
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

# rust
hook global WinSetOption filetype=rust %{
      set window formatcmd 'rustfmt'
}

# go
hook global WinSetOption filetype=go %{
      set window formatcmd 'gofmt'
}

# ruby
hook global WinSetOption filetype=ruby %{
    set-option window lintcmd 'run() { cat "$1" | /Users/oem/.rbenv/shims/rubocop -s "$kak_buffile"; } && run '
    set-option window formatcmd '/Users/oem/.rbenv/shims/rubocop -a "$kak_buffile"'
    lint-enable
}

# python
hook global WinSetOption filetype=python %{
  jedi-enable-autocomplete
  lint-enable
  set-option global lintcmd 'flake8'
  set window formatcmd 'black'
}

set-option global indentwidth 2
hook global BufWritePre .* %{
  evaluate-commands %sh{
    if [ -n "$kak_opt_formatcmd" ]; then
      printf "format-buffer\n"
    else
      printf "\n"
    fi
  }
}

hook global WinCreate .* %{ try %{
    add-highlighter buffer/matching         show-matching
    add-highlighter buffer/wrap             wrap -word -indent -marker '↪'
    add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
}}
