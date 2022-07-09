# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors and change prompt:
autoload -U colors && colors


# vi mode
bindkey -v
[ ! -z $DISPLAY ] &&  export KEYTIMEOUT=1 || if [ 1 ]; then; fi



# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

vi_mode () {

	zle -N zle-line-init
	echo -ne '\e[5' # Use beam shape cursor on startup.
	preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
}
[ ! -z $DISPLAY ] && vi_mode || if [ 1 ]; then; fi

# color on man pages
###


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line



# Aliases
source $HOME/.config/aliases


# Load syntax highlighting
if [[ -z /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -z /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# source user profile
source $HOME/.profile
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# History in cache directory:
HISTSIZE=1000000
SAVEHIST=1000000
[ ! -d $HOME/.cache/zsh ] && mkdir $HOME/.cache/zsh
HISTFILE=~/.cache/zsh/history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

kill-wine() {
	pkill -KILL winedevice.exe
	pkill -KILL wineserver
	pkill -KILL wineboot.exe
	pkill -KILL wine64
}

eval "$(zoxide init zsh)"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
