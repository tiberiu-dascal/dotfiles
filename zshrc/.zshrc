# If on WSL on work laptop, load fzf
if uname -n | grep -q "ROTDASCAL01"; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
