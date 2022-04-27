#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH SOURCES 
typeset -ga sources
for file in $ZDOTDIR/core/*.zsh; do 
    source "$file"
done

# ZI
ZI[HOME_DIR]=$HOME/.zi
Zi[BIN_DIR]=$HOME/.zi/bin
source $HOME/.zi/bin/zi.zsh

if [[ ! -d $HOME/.zi ]]; then
  command mkdir -p $HOME/.zi && command chmod g-rwX $HOME/.zi \
  command sh -c "$(curl -fsSL https://git.io/get-zi)" -- -a zunit \
  command zi module build && typeset -g ZI_MOD_DEBUG=1
fi

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# p10k
zt light-mode for \
pick'async.zsh' \
  mafredri/zsh-async \
  romkatv/powerlevel10k 

# These plugins provide many aliases - atload''
zi wait lucid for \
  OMZ::lib/git.zsh \
atload"unalias grv" \
  OMZ::plugins/git/git.plugin.zsh

# history
zt atinit'HISTFILE="${HOME}/.cache/zsh/.zhistory"' for \
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


# Plugins
zi light-mode for \
blockf lucid atpull"zi creinstall -q ."
  zsh-users/zsh-completions \
compile"{src/*.zsh,src/strategies/*}" pick"zsh-autosuggestions.zsh" \
atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
pick'fz.sh' atload"ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert __fz_zsh_completion)" \
  changyuheng/fz
atinit'zicompinit_fast; zicdreplay' atload"FAST_HIGHLIGHT[chroma-man]=" \
  zdharma-continuum/F-Sy-H \
blockf atpull"zi creinstall -q ." \
atinit" \
  zstyle ':completion:*::::' completer _complete _expand _ignored _approximate \
  zstyle ':completion:*:match:*' original only \
  zstyle -e ':completion:*:approximate:*' max-errors "reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)" \
  zstyle ':completion:*:matches' group "yes" \
  zstyle ':completion:*:options' description "yes" ,
  zstyle ':completion:*:options' auto-description "%d" \
  zstyle ':completion:*:corrections' format " %F{green}-- %d (errors: %e) --%f" \
  zstyle ':completion:*:descriptions' format " %F{yellow}-- %d --%f" \
  zstyle ':completion:*:messages' format " %F{purple} -- %d --%f" \
  zstyle ':completion:*:warnings' format " %F{red}-- no matches found --%f" \
  zstyle ':completion:*:default' list-prompt "%S%M matches%s" \
  zstyle ':completion:*' format " %F{yellow}-- %d --%f" \
  zstyle ':completion:*' group-name '' \
  zstyle ':completion:*' verbose yes \
  zstyle ':completion:*' matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*" \
  zstyle ':completion:*:functions' ignored-patterns "(_*|pre(cmd|exec))" \
  zstyle ':completion:*' accept-exact "*(N)" \
  zstyle ':completion:*' use-cache true \
  zstyle ':completion:*' cache-path "$HOME/.cache/zsh" \
  zstyle ':completion:*' rehash true \
  zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin \
  zstyle ':completion:*:expand:*' tag-order all-expansions \
  zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories \
  zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”" \
  zsh-users/zsh-completions \
bindmap"^R -> ^H" atinit"\
  zstyle :history-search-multi-word page-size 10 \
  zstyle :history-search-multi-word highlight-color fg=red,bold \
  zstyle :plugin:history-search-multi-word reset-prompt-protect 1" \
  zdhadrma-continuum/H-S-MW \
atload"
  bindkey "$terminfo[kcuu1]" history-substring-search-up;
  bindkey "$terminfo[kcud1]" history-substring-search-down" \
  zsh-users/zsh-history-substring-search \
reset \
atinit"export LS_COLORS='$(vivid generate dracula)'" \
atload"zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'" \
  sharkdp/vivid \

# Semi-graphical .zshrc editor for zi commands
zi load zdharma-continuum/zui
zi ice lucid wait"[[ -n ${ZLAST_COMMANDS[(r)cras*]} ]]"
zi load zdharma-continuum/zi-crasis

# Cargo 
source $HOME/.cargo/env

# neofetch-btw
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate dracula)"

# p10k
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh 
