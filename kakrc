colorscheme palenight
decl int indentwidth 4
decl bool aligntab false
decl bool ncurses_set_title false

# Add line numbers to everything
# hook global WinCreate .* %{add-highlighter buffer number-lines}
# hook global WinCreate ^[^*]+$ %{ add-highlighter window/ number-lines -hlcursor }

# Rescuse clippy
set global ui_options ncurses_assistant=clippy


#map global user b buffer-next
#map global user B buffer-previous
map global user | |fold<space>-w78<space>-s<ret>

map global user b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
alias global cs colorscheme
#alias global bl buffer-last

#copy to clipboard
hook global NormalKey y|d|c %{ nop %sh{
printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

# Nice things for C
hook global WinCreate .*\.c %{
clang-enable-autocomplete
clang-enable-diagnostics
hook global InsertEnd .* %{
clang-parse
}
}

hook global WinCreate .*\.h %{
clang-enable-autocomplete
clang-enable-diagnostics
}

# Nice things for Golang
hook global WinCreate .*\.go %{
echo -debug "Go mode"
go-enable-autocomplete
map buffer user ? :go-doc-info<ret>
map buffer user j :go-jump<ret>
}
hook global BufWritePre .*\.go %{
go-format
}
# Softwrap text files and markdown
hook global WinCreate .*\.md %{
add-highlighter buffer wrap -word -indent
echo -debug "Softwrap enabled"
}
hook global WinCreate .*\.txt %{
add-highlighter buffer wrap -word -indent
echo -debug "Softwrap enabled"
}
# Nice things for Haskell
hook global WinCreate .*\.hs %{
map buffer insert <tab> '<a-;><gt>'
map global insert <backtab> '<a-;><lt>'
set buffer tabstop 4
set buffer indentwidth 4
set buffer aligntab false
echo -debug "Haskell Mode"
}
