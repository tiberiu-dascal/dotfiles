if [[ hostname == "OTX-HBKT2D3" ]]; then
    plugins=( git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting omw )
else
    plugins=( git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting )
fi

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
source <(gh completion -s zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

eval "$(starship init zsh)"
