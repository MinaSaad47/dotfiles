export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -d $HOME/.local/bin ]; then
	export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d $HOME/.local/cross/bin ]; then
	export PATH="$PATH:$HOME/.local/cross/bin"
fi

if [ -d $HOME/bin ]; then
	export PATH="$PATH:$HOME/bin"
fi

if [ -d $HOME/.local/share/scripts ]; then
	export PATH="$PATH:$HOME/.local/share/scripts"
fi

if [ -d $HOME/.cargo/bin/ ]; then
	export PATH="$PATH:$HOME/.cargo/bin/"
fi


if [ -d $HOME/.local/share/android/ ]; then
    export ANDROID_SDK_ROOT="$HOME/.local/share/android/sdk"
	export PATH="$PATH:$HOME/.local/opt/android-studio/bin"
fi

if [ -d $HOME/.local/share/flutter/bin ]; then
	export PATH="$PATH:$HOME/.local/share/flutter/bin"
fi

if [ -d $HOME/.pub-cache/bin ]; then
    export PATH="$PATH:$HOME/.pub-cache/bin"
fi

if [ -d $HOME/.local/share/jdk/bin ]; then
    export PATH="$PATH:$HOME/.local/share/jdk/bin"
    export JAVA_HOME="$HOME/.local/share/jdk"
fi

export EDITOR=nvim

NPM_PACKAGES="${HOME}/.npm-packages"

export NNN_PLUG='s:ffspeed;f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview;r:rsynccp;'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
