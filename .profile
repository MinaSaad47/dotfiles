export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

if [ -d $HOME/.local/share/flatpak/exports/bin/ ]; then
    export PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"
fi

if [ -d $HOME/.local/share/nvim/mason/bin ]; then
    export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
fi

if [ -d $HOME/.local/bin ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d $HOME/.local/cross/bin ]; then
	export PATH="$HOME/.local/cross/bin:$PATH"
fi

if [ -d $HOME/bin ]; then
	export PATH="$HOME/bin:$PATH"
fi

if [ -d $HOME/.local/share/scripts ]; then
	export PATH="$PATH:$HOME/.local/share/scripts"
fi

if [ -d $HOME/.cargo/bin ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d $HOME/.config/scripts ]; then
	export PATH="$PATH:$HOME/.config/scripts"
fi


if [ -d $HOME/.local/opt/android ]; then
    export JAVA_HOME="$HOME/.local/opt/android/android-studio/jbr"
    export PATH="$PATH:$HOME/.local/opt/android/android-studio/jbr/bin"
    export ANDROID_HOME="$HOME/.local/opt/android/sdk"
    export ANDROID_SDK_ROOT="$HOME/.local/opt/android/sdk"
    export ANDROID_USER_HOME="$HOME/.local/opt/android/.android"
    # export ANDROID_SDK_HOME="$HOME/.local/opt/android/.android"
    export PATH="$PATH:$HOME/.local/opt/android/android-studio/bin"
    export PATH="$PATH:$HOME/.local/opt/android/sdk/tools/bin"
fi

if [ -d $HOME/.local/share/flutter/bin ]; then
	export PATH="$PATH:$HOME/.local/share/flutter/bin"
fi

if [ -d $HOME/.pub-cache/bin ]; then
    export PATH="$PATH:$HOME/.pub-cache/bin"
fi

export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

export NPM_PACKAGES="$HOME/.local/share/npm-packages"

if [ -d $NPM_PACKAGES ]; then
    export PATH="$PATH:$NPM_PACKAGES/bin"
    # export MANPATH="$(manpath):$NPM_PACKAGES/share/man"
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
fi

if [ -d $HOME/.local/opt/libtorch ]; then
    export LIBTORCH="$HOME/.local/opt/libtorch"
    export LD_LIBRARY_PATH="$LIBTORCH/lib:$LD_LIBRARY_PATH"
    export LIBTORCH_INCLUDE="$LIBTORCH/"
    export LIBTORCH_LIB="$LIBTORCH/"
    export TORCH_CUDA_VERSION="cu118"
fi

export CHROME_EXECUTABLE=$HOME/.nix-profile/bin/chromium

# nvim editor
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

# virt
export LIBVIRT_DEFAULT_URI="qemu:///system"

# nnn file manager
export NNN_PLUG='s:ffspeed;f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview;r:rsynccp;'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
