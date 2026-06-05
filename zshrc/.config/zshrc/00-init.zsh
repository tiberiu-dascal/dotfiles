export BAT_THEME="Catppuccin-mocha"
export ENCODED_GITHUB_TOKEN=Z2hwX3o3V0xGU3RsR2dxOXhlMUI5Uld1MFo5VHJaOTJycjBrUzJrRgo=
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export REPOS_DIR=$HOME/REPOS
export VISUAL=nvim
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.config/emacs/bin/

# if emacs is installed, add emacs's bin folder to the path
if command -v emacs &>/dev/null; then
  export PATH=$PATH:$HOME/.config/emacs/bin/
fi

export NVM_DIR="$HOME/.nvm"
# Lazy-load nvm: sourcing nvm.sh eagerly costs ~950ms at startup (nvm_auto checks
# the default node version). Instead, stub the commands and load nvm on first use.
if [ -s "$NVM_DIR/nvm.sh" ]; then
  _load_nvm() {
    unset -f nvm node npm npx _load_nvm 2>/dev/null
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }
  nvm()  { _load_nvm; nvm "$@"; }
  node() { _load_nvm; node "$@"; }
  npm()  { _load_nvm; npm "$@"; }
  npx()  { _load_nvm; npx "$@"; }
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

#eval "$(mise activate zsh)"

