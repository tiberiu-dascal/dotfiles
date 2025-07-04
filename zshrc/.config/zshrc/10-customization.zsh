plugins=( git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting )

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
source <(gh completion -s zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

eval "$(uv generate-shell-completion zsh)"
eval "$(starship init zsh)"
