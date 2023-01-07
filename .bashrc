source $HOME/.profile

P_PROC="$(ps --no-header --pid=$PPID --format=comm)"
if [[ $P_PROC != "fish" && $P_PROC != "sddm-helper" && -z ${BASH_EXECUTION_STRING} ]]
then
	SHELL='/usr/bin/fish'
	exec fish
fi
