pokemon-colorscripts --no-title -r

# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export PATH="$HOME/.atuin/bin:$PATH"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zsh themes
source ~/.local/share/zinit/plugins/catppuccin---zsh-syntax-highlighting/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light catppuccin/zsh-syntax-highlighting

# snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# keybindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region

# History
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_verify

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --show-symlinks --git-ignore --icons --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -a -1 --show-symlinks --git-ignore --icons --color=always $realpath'

# shell integrations
eval "$(fzf --zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# fzf integrations
fcd() {
  local dir
  dir=$(find . -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Export
export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,gutter:-1,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"

export BAT_THEME="Catppuccin Macchiato" # base16-256, Dracula
export EDITOR=nvim
export VISUAL="$EDITOR"
export SUDO_EDITOR $EDITOR

# Starship
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Ohmyposh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
 eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/p10k.toml)"
fi

# I-beam cursor
echo -ne "\e[5 q"

# nvims
#function nvims() {
#  items=$(find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;)
#  selected=$(printf "%s\n" "${items[@]}" | \
#    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} --prompt='   Neovim Configs' --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200'" \
#    fzf)
#
#  if [[ -z $selected ]]; then
#    return 0
#  elif [[ $selected == "nvim" ]]; then
#    selected=""
#  fi
#  NVIM_APPNAME=$selected nvim "$@"
#}

# fzf-nvim
function fzf-nvim {
    file=$(fzf --height 100% --preview 'bat --style=numbers --color=always {}')
    if [ -n "$file" ]; then
        nvimPath="/opt/homebrew/bin/nvim"  # Path to Neovim
        if command -v nvim &> /dev/null; then
            "$nvimPath" "$file" || echo "Failed to open Neovim."
        else
            echo "Neovim is not installed."
        fi
    else
        echo "No file selected."
    fi
}

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# PERL
PATH="/home/eyes/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/eyes/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/eyes/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/eyes/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/eyes/perl5"; export PERL_MM_OPT;
export PERL5LIB=/home/eyes/perl5/lib/perl5:$PERL5LIB

# aliasis
alias la='eza -a --icons'
alias ls='eza --icons'
alias ll='eza -a -l --icons'
alias tree='eza -a -T --git-ignore --icons'
alias lta4="eza -lTag --git-ignore --level=4 --icons"
alias rm='trash-put'
alias tmux='tmux -f ~/.tmux.conf'
alias rg='rg -i'
alias branch='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1} | delta" --pointer="" | xargs git checkout'
alias preview='kitten icat'
alias gen='tgpt -i'
alias profile='preview ~/.face.icon'
alias preview='kitten icat'
alias powertop='sudo powertop'
alias words='tt -theme ~/.tt/Catppuccin-Macchiato'
alias clock='tty-clock -DScC6b'
alias bonsai='cbonsai --seed 119'
alias matrix="unimatrix -n -c yellow -s 90 -l 'o'"
alias doom='~/.local/bin/doom'
alias weather='curl "wttr.in/Agartala?F"'
alias zed='zeditor'
alias asciiquarium='asciiquarium -t'
