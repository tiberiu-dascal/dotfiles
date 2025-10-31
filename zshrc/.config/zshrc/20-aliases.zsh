# WSL specific aliases
if uname -n | grep -q "ROTDASCAL01" ;then
  alias k='kubectl.exe'
  alias minikube='minikube.exe'
fi

# Navigation aliases (ls/exa/eza)
alias ls='eza --icons -g'
alias lsa='ls -a'
alias ll='ls -l'
alias la='ll -a'
alias lT='ls -T'
alias lH='ls -ltr'

# NVIM ALIASES #
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-cosmic="NVIM_APPNAME=CosmicNvim nvim"
alias nvim-lunar="NVIM_APPNAME=LunarVim nvim"

# Qualit Of Life Aliases
alias aliases='alias | fzf --height 40% --layout reverse --border'
alias cls='clear'
alias clera='clear'
alias ghcs="gh copilot suggest"
alias pfzf="fzf \
  --style full \
  --preview 'bat --color=always --style=numbers --line-range :500 {}' \
  --bind 'focus:transform-preview-label:[[ -n  {}  ]] && printf \"Previewing [%s] \" {}' \
  --border --padding 1,2 \
  --border-label ' Search with preview ' \
  --input-label ' Search for ... ' \
  --color 'border:#aaaaaa,label:#cccccc' \
  --color 'preview-border:#9999cc,preview-label:#ccccff' \
  --color 'list-border:#669966,list-label:#99cc99' \
  --color 'input-border:#996666,input-label:#ffcccc' \
  --color 'header-border:#6699cc,header-label:#99ccff'"
alias aliases='alias | fzf --prompt="Alias >> " --height=~65% --layout=reverse --border --exit-0'
alias rec_start='ffmpeg -f avfoundation -capture_cursor 1 -capture_mouse_clicks 1 -i "Capture screen 0" $HOME/Movies/RECORDINGS/RAW_FOOTAGE/MAC_REC_$(date "+%Y%m%d_%H_%M_%S")_RAW.mkv &>/dev/null'
alias repoup='find $HOME/REPOS -maxdepth 1 -type d 2>/dev/null > $HOME/.tmp/gitfiles'
alias zedit='nvim $HOME/.zshrc'
alias lg='lazygit'

# youtube-dl aliases
alias yta-aac='youtube-dl --extract-audio --audio-format aac '
alias yta-best='youtube-dl --extract-audio --audio-format best '
alias yta-flac='youtube-dl --extract-audio --audio-format flac '
alias yta-m4a='youtube-dl --extract-audio --audio-format m4a '
alias yta-mp3='youtube-dl --extract-audio --audio-format mp3 '
alias yta-opus='youtube-dl --extract-audio --audio-format opus '
alias yta-vorbis='youtube-dl --extract-audio --audio-format vorbis '
alias yta-wav='youtube-dl --extract-audio --audio-format wav '
alias ytv-best='youtube-dl -f bestvideo+bestaudio '

# PHP Aliases
alias art='php artisan'

# List all nvims flavors and load the selected one
function nvims() {
	local vims=("default" "AstroNvim" "LazyVim" "NvChad" "CosmicNvim" "LunarVim" "PyNvim")

	config=$(printf "%s\n" "${vims[@]}" | fzf --prompt="Load  Config for >> " --height=20% --layout=reverse --border --exit-0)

	if [[ -z $config ]]; then
		echo "Nothing selected"
		return 0
	elif [[ $config == "default" ]]; then
		config=""
	fi
	NVIM_APPNAME=$config nvim "$@"
}

bindkey -s ^n "nvims\n"

# List all repos in $HOME/REPOS and make a searcheable list unsing fzf
# When selected, it will cd into the selected repo
function repos() {
  REPOS="$(cat $HOME/.tmp/gitfiles | sort -d | xargs -n 1 basename)"
  repo=$(printf "%s\n" "${REPOS[@]}" | fzf --prompt=" Repos >> " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $repo ]]; then
     echo "Nothing selected"
     return 0
  else
    cd $HOME/REPOS/$repo
  fi

}
bindkey -s ^a "repos\n"

fd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
