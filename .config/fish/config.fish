pokemon-colorscripts --no-title -r

fish_config theme choose "Catppuccin Macchiato" # Catppuccin Macchiato, Dracula Official

# XDG Directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_STATE_HOME $HOME/.local/state
set -xg XDG_BIN_HOME $HOME/.local/bin
set -x MANPATH /usr/share/man:/usr/local/man:/usr/local/share/man

# Fisher
if not type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source 
end

set sponge_allow_previously_successful false #sponge fish plugin

#oh-my-posh init fish --config ~/.config/ohmyposh/p10k.toml | source

# Starship Prompt
function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

atuin init fish | source

# backups
function backup --argument filename
    cp $filename $filename.bak
end

# bat
set -gx BAT_THEME "Catppuccin Macchiato" # base16-256, Catppuccin Macchiato, Dracula

# curl
fish_add_path /opt/homebrew/opt/curl/bin
  set -gx LDFLAGS "-L/opt/homebrew/opt/curl/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/curl/include"

# fish
set -g theme_nerd_fonts yes

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
alias private='fish -P'
alias asciiquarium='asciiquarium -t'
alias powertop='sudo powertop'
alias words='tt -theme ~/.tt/Catppuccin-Macchiato'
alias clock='tty-clock -DScC6b'
alias bonsai='cbonsai --seed 119'
alias matrix="unimatrix -n -c yellow -s 90 -l 'o'"
alias doom='~/.local/bin/doom'
alias weather='curl "wttr.in/Agartala?F"'
alias zed='zeditor'

# homebrew
set -x HOMEBREW_NO_ENV_HINTS 1

if test -d /home/linuxbrew/.linuxbrew

      set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
      set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
      set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
      set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
      set -q MANPATH; or set MANPATH ''
      set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
      set -q INFOPATH; or set INFOPATH ''
      set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
      set -gx HOMEBREW_GITHUB_API_TOKEN {api token goes here, don't remember where that's created}
  else if test -d /opt/homebrew
      /opt/homebrew/bin/brew shellenv | source
end

# FZF
set -xg FZF_DEFAULT_COMMAND fd
set -xg FZF_DEFAULT_OPTS "--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1 \
--color=bg+:-1,gutter:-1,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
--bind 'ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)'"
set -xg fzf_preview_dir_cmd eza --long --header --icons --all --color=always --group-directories-first --hyperlink
set -xg fzf_fd_opts --hidden --color=always
set -xg _ZO_FZF_OPTS $FZF_DEFAULT_OPTS '--preview "{$fzf_preview_dir_cmd} {2}"'

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
starship init fish | source
enable_transience

# yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# editor
set -xg EDITOR nvim
set -xg VISUAL $EDITOR
set -xg SUDO_EDITOR $EDITOR

# nvims
#function neovims
#    set items (find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;)
#    set selected (printf "%s\n" $items | fzf --prompt='   Neovim Configs ' --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200')
#
#    if test -z "$selected"
#        return 0
#    else if test "$selected" = "nvim"
#        set selected ""
#    end
#
#    set NVIM_APPNAME $selected
#    nvim $argv
#end

# ollama
function ollama-serve
    ollama serve > /dev/null 2>&1 &
end

function ollama-kill
    pkill ollama
end

# zoxide
zoxide init --cmd cd fish | source

set -g fish_greeting ""
