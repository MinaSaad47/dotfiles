#!/bin/bash
source "$HOME/.profile"

P_PROC="$(ps --no-header --pid=$PPID --format=comm)"
if [[ $P_PROC != "fish" && $P_PROC != "sddm-helper" && -z ${BASH_EXECUTION_STRING} ]]
then
	SHELL='/usr/bin/fish'
	exec fish
    exit
fi

source "$HOME/.config/aliases"
eval "$(starship init bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

