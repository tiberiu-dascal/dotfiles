# If on WSL on work laptop, load fzf
if uname -n | grep -q "ROTDASCAL01"; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

for f in $HOME/.config/zshrc/* ;do
    source $f
done
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
