set -U fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $HOME/.config/aliases
command -v zoxide >/dev/null && zoxide init fish | source
command -v starship >/dev/null && starship init fish | source
