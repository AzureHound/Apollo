# XDG Directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_STATE_HOME $HOME/.local/state
set -xg XDG_BIN_HOME $HOME/.local/bin
set -xg XDG_SCRIPT_HOME $HOME/.local/script

# Respect XDG Specification
set -xg CONAN_USER_HOME $XDG_CONFIG_HOME
set -xg GOPATH $XDG_DATA_HOME/go
set -xg GOMODCACHE $XDG_CACHE_HOME/go/mod
set -xg RUSTUP_HOME $XDG_DATA_HOME/rustup
set -xg CARGO_HOME $XDG_DATA_HOME/cargo
set -xg ANDROID_USER_HOME $XDG_DATA_HOME/android
set -xg DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -xg RIPGREP_CONFIG_PATH $HOME/.config/rg/.ripgreprc
set -xg STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set -xg FFMPEG_DATADIR $XDG_CONFIG_HOME/ffmpeg
set -xg PYENV_ROOT $XDG_DATA_HOME/pyenv
set -xg XINITRC $XDG_CONFIG_HOME/X11/xinitrcexport
set -xg XSERVERRC $XDG_CONFIG_HOME/X11/xserverrc
set -xg HISTFILE $XDG_STATE_HOME/bash/history
set -xg WINEPREFIX $XDG_DATA_HOME/wine
set -xg NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -xg GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -xg W3M_DIR $XDG_DATA_HOME/w3m
set -xg DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet

# Path
fish_add_path $XDG_BIN_HOME
fish_add_path $XDG_BIN_HOME/color-scripts/
fish_add_path $GOPATH/bin
fish_add_path $CARGO_HOME/bin
fish_add_path $XDG_SCRIPT_HOME
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/bin
fish_add_path /usr/sbin
fish_add_path /bin
fish_add_path /sbin
fish_add_path /usr/lib/rustup/bin
fish_add_path /usr/lib/go/bin
fish_add_path $HOME/.dotnet/tools
fish_add_path $XDG_DATA_HOME/npm/bin
fish_add_path $HOME/.yarn/bin

# Editor
set -xg EDITOR nvim
set -xg VISUAL $EDITOR
set -xg SUDO_EDITOR $EDITOR
