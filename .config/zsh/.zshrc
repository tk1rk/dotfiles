#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH SOURCES 
typeset -ga sources
for file in "$ZDOTDIR/config/*.zsh"; do 
    source "$file"
done

source "$ZSH_PLUGINS/colorize/colorize.plugin.zsh"
source "$ZSH_PLUGINS/command-not-found/command-not-found.plugin.zsh"
source "$ZSH_PLUGINS/extract/extract.plugin.zsh"
source "$ZSH_PLUGINS/history-substring-search/history-substring-search.plugin.zsh"
source "$ZSH_PLUGINS/zsh-exa/zsh-exa.plugin.zsh"

ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
ZSH_HIGHLIGHT_MAXLENGTH=512
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$color8,bold"

# ZI
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# p10k
zi light-mode for \
pick'async.zsh' \
  mafredri/zsh-async \
  romkatv/powerlevel10k 

# history
zt atinit'HISTFILE="$HOME/.cache/zsh/.zhistory"' for \
  OMZL::history.zsh

# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

# Annexes
# Load a few important annexes, without Turbo.
zi light-mode compile"*handler" for \
z-shell/z-a-patch-dl \
z-shell/z-a-readurl \
z-shell/z-a-bin-gem-node \
z-shell/z-a-submods
zi light z-shell/declare-zsh

# Semi-graphical .zshrc editor for zi commands
zi load zdharma-continuum/zui
zi ice lucid wait"[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]"
zi load zdharma-continuum/zi-crasis

zi ice from'gh-r' as'program'
zi light @junegunn/fzf

zi ice from'gh-r' as'program' mv'fd* fd' sbin'**/fd(.exe|) -> fd'
zi light @sharkdp/fd

zi ice from'gh-r' as'program' mv'bat* bat' sbin'**/bat(.exe|) -> bat'
zi light @sharkdp/bat

zi ice lucid wait as'program' has'bat' pick'src/*'
zi light eth-p/bat-extras

zi ice from'gh-r' as'program' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid'
zi light @sharkdp/vivid

zi ice wait lucid as'program' pick'zunit' atclone'./build.zsh' atpull'%atclone'
zi load @zdharma/zunit




### completions ###
zi ice lucid wait as'completion' blockf has'alacritty'
zi snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty

zi ice lucid wait as'completion' blockf has'fd'
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fd/_fd

zi ice lucid wait as'completion' blockf has'yadm'
zi snippet https://github.com/TheLocehiliosan/yadm/blob/master/completion/zsh/_yadm

zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zi ice lucid wait as'completion' blockf pick'src/go' src'src/zsh'
zi light zchee/zsh-completions




# Cargo 
source $HOME/.cargo/env

# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh 
