# If on WSL on work laptop, load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f $HOME/.zshenv ] && source $HOME/.zshenv

for f in $HOME/.config/zshrc/* ;do
    if [[ $f != "99-work.zsh" ]]; then
        source $f
    fi
done

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [[ hostname == "OTX-HBKT2D3" ]]; then
    [ -f ~/.config/zshrc/99-work.zsh ] && source ~/.config/zshrc/99-work.zsh
fi


# Load nvim installed through YAY
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

