export BAT_THEME="Catppuccin-mocha"
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export REPOS_DIR=$HOME/REPOS
export VISUAL=nvim
export ZSH="$HOME/.oh-my-zsh"
if [ "$(hostname)" = "TBMBPM3.local" ]; then
  export JAVA_HOME="/usr/local/Cellar/openjdk@17/17.0.8"
fi
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.config/emacs/bin/

# if emacs is installed, add emacs's bin folder to the path
if command -v emacs &>/dev/null; then
  export PATH=$PATH:$HOME/.config/emacs/bin/
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Update Path for GCloud SDK and completion on Mac
if uname -s | grep -q "Darwin" ;then
    if [ -f '$HOME/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/Downloads/google-cloud-sdk/path.zsh.inc'; fi
    if [ -f '$HOME/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
fi

if [ "$(hostname)" = "OTX-HBKT2D3" ]; then
  . "$HOME/.cargo/env"
  . "$HOME/.local/share/bob/env/env.sh"
  eval "$(mise activate bash)"
fi

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#f4b8e4,bold,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#f4b8e4,bold,underline'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#f4b8e4,bold,underline'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#f4b8e4'

FZF_DEFAULT_OPTS="\
  --color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Export TMUX_AUTOSTART=1 on WSL at work (ROTDASCAL01) and on Mac (TBMBPM3.local)
if [ "$(hostname)" = "OTX-HBKT2D3" ] || [ "$(hostname)" = "tb-thinkX1" ]; then
    export TMUX_AUTOSTART=1
fi

# Start tmux if TMUX_AUTOSTART is set
if [[ -v TMUX_AUTOSTART ]]; then
  if [ ! "$TMUX" ]; then
    tmux attach -t "👨🏻‍💻" || tmux new -s "👨🏻‍💻"
  fi
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
