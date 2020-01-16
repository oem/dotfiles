source "%val{config}/plugins/plug.kak/rc/plug.kak"

# fuzzy
map -docstring 'all file contents' global user / %{: fzf -kak-cmd %{evaluate-commands} -items-cmd %{rg --column --line-number --no-heading --color=never --smart-case ''} -filter %{sed -e 's/\([^:]*\):\([^:]*\):\([^:]*\):.*/edit -existing \1 \2 \3/'}<ret>}

plug "andreyorst/fzf.kak" config %{
    map global user d '<esc>:fzf-mode<ret>' -docstring "fzf all"
    map global user f '<esc>:fzf-mode<ret>f' -docstring "fzf"
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
    hook global WinSetOption filetype=(c|cpp|go|rust|ruby|javascript) %{
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

hook global WinCreate .* %{ try %{
    set-face global Whitespace 'rgb:444444'
    set-face global BufferPadding 'rgb:131313'
    set-face global WrapMarker 'rgb:444444'
    add-highlighter buffer/matching         show-matching
    add-highlighter buffer/wrap             wrap -word -indent -marker '↪'
    add-highlighter buffer/show-whitespaces show-whitespaces -lf '¶' -spc '⋅' -nbsp '⋅'
}}

hook global BufWritePost .* %{ git show-diff }
hook global BufReload    .* %{ git show-diff }

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

# tab completion
hook global InsertCompletionShow .* %{
    try %{
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

# languages

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
    set-option window lintcmd 'run() { cat "$1" | rubocop "$kak_buffile"; } && run '
    set-option current formatcmd "(bundle exec rubocop -o /dev/null -x -s %val{bufname} | tail -n +2)"
    set-option window indentwidth 2
    lint-enable
    lint
    git show-diff
    # hook buffer BufWritePre .* format
    hook buffer BufWritePost .* lint
}

# python
hook global WinSetOption filetype=python %{
    set-option global lsp_server_configuration pyls.configurationSources=["flake8"]
    jedi-enable-autocomplete
    set global lintcmd kak_pylint
    set window formatcmd 'black -q  -'
    lint-enable
    lint
    hook buffer BufWritePre .* format
    hook buffer BufWritePost .* lint
}

# frontend stuff
hook global WinSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml|html) %{
        set-option buffer formatcmd "prettier --stdin-filepath=%val{buffile}"
            hook buffer -group format BufWritePre .* format
}

