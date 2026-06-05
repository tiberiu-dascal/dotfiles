# Auto-start tmux BEFORE p10k instant prompt grabs the tty.
# (Running tmux after instant prompt causes "open terminal failed: not a terminal".)
if [[ -o interactive && -z "$TMUX" && -t 1 && "$TERM" != screen* && "$TERM" != tmux* ]]; then
  # No `exec`: when you detach or exit tmux, control returns to this shell
  # (which then finishes loading below) instead of closing the terminal.
  tmux new -A -s "👨🏻‍💻"
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1;zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-contrib/zsh-fzf
zinit light jeffreytse/zsh-vi-mode

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker

# Cache completion init: only rebuild the dump once a day (~300ms saved otherwise).
autoload -Uz compinit
_zcd=$HOME/.zcompdump
if [[ -f $_zcd && -z $_zcd(#qN.mh+24) ]]; then
  compinit -C -d $_zcd   # dump is fresh (<24h): skip the slow security audit
else
  compinit -d $_zcd      # rebuild dump
fi
unset _zcd

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --color=always -T -L 1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --color=always -T -L 1 $realpath'

# Aliases
alias ls='eza --icons'
alias k='kubectl'
alias ll='ls -la'
alias cat=bat

bindkey -e

# zsh-vi-mode resets all keymaps during its own (deferred) init, which runs
# AFTER .zshrc. Binding keys here directly would be wiped, so register them in
# its zvm_after_init hook instead.
zvm_after_init_commands+=(
  'bindkey "^r" fzf-history-widget'
  'bindkey "^n" history-search-forward'
  'bindkey "^p" history-search-backward'
)

export MANPAGER='nvim +Man!'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# Cache slow `eval "$(... completion)"` generators to a file; regenerate only
# when the source binary is newer than the cache (e.g. after a package upgrade).
_cache_init() {
  local name=$1 bin=$2; shift 2
  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/${name}.zsh"
  if [[ ! -f $cache || $commands[$bin] -nt $cache ]]; then
    mkdir -p ${cache:h}
    "$@" > $cache 2>/dev/null
  fi
  source $cache
}

_cache_init kubectl kubectl kubectl completion zsh

for f in $HOME/.config/zshrc/*;do
    if [[ ${f:t} != "99-work.zsh" ]]; then
        source $f
    fi
done

# fzf shell integration — must come after the config loop so that mise has
# already activated and put the fzf binary on PATH.
source <(fzf --zsh)

# Check if sdkman (Java Version manager) is installed and initialize it
if command -v sdk &>/dev/null; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Check if pyenv is installed and initialize it
if  command -v pyenv &>/dev/null; then
    # Load pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

# Check if gh (Github CLI Tool is installed and add completion)
if command -v gh &>/dev/null; then
    _cache_init gh gh gh completion -s zsh
fi

# zoxide must be initialized at the very end (it wraps `cd`); doing it last also
# silences zoxide's "configuration issue" warning.
eval "$(zoxide init --cmd cd zsh)"

export PATH="$HOME/.local/bin:$PATH"
