set -U fish_greeting
set TERM 'xterm-256color'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $HOME/.config/aliases
command -v zoxide >/dev/null && zoxide init fish | source
command -v starship >/dev/null && starship init fish | source
command -v afetch >/dev/null && afetch
