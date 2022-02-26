#!/usr/bin/env zsh

### ZSH SOURCES ###
typeset -ga sources
for file in "${ZDOTDIR}/include/aliases.zsh" \
            "${ZDOTDIR}/include/bindkeys.zsh \
            "${ZDOTDIR}/include/completion.zsh" \
            "${ZDOTDIR}/include/functions.zsh" \
            "${ZDOTDIR}/include/less.zsh" \
            "${ZDOTDIR}/include/setopt.zsh" \
            "${ZDOTDIR}/include/less.zsh" \
            "${ZSH_PLUGINS}/find-the-command/ftc.zsh" \
            "${ZSH_PLUGINS}/zsh-defer/zsh-defer.plugin.zsh" \
            "${ZSH_PLUGINS}/auto-ls-zsh/auto-ls.zsh" 
    [ -s "${file}" ] && source "${file}"
done

# bash completion
autoload -U +X bashcompinit && bashcompinit

# colors
autoload -U colors; colors

# Clone zcomet (if necessary)
if [[ ! -f ${ZDOTDIR}/zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR}/zcomet/bin
fi
# zcomet source
source ${ZDOTDIR}/zcomet/bin/zcomet.zsh
mkdir -p $ZDOTDIR/zcomet/{repos,snippets}

# zcomet directories
zstyle ':zcomet:*' home-dir $ZDOTDIR/zcomet
zstyle ':zcomet:*' repos-dir $ZDOTDIR/zcomet/repos
zstyle ':zcomet:*' snippets-dir $ZDOTDIR/zcomet/snippets

# Theme (powerlevel10k)
zcomet load romkatv/powerlevel10k

# ohmyzsh plugins
zcomet load ohmyzsh lib compfix.zsh 
zcomet load ohmyzsh lib completion.zsh 
zcomet load ohmyzsh lib correction.zsh 
zcomet load ohmyzsh lib functions.zsh
zcomet load ohmyzsh lib git.zsh
zcomet load ohmyzsh lib termsupport.zsh 
zcomet load ohmyzsh lib theme-and-appearance

# omzp snippets
zcomet load ohmyzsh plugins/colored-man-pages
zcomet load ohmyzsh plugins/command-not-found
zcomet load ohmyzsh plugins/direnv
zcomet load ohmyzsh plugins/docker
zcomet load ohmyzsh plugins/docker-compose
zcomet load ohmyzsh plugins/extract
zcomet load ohmyzsh plugins/fzf
zcomet load ohmyzsh plugins/ripgrep
zcomet load ohmyzsh plugins/rust

### Programs 
zcomet trigger bat sharkdp/bat
zcomet trigger bottom bt ClementTsang/bottom
zcomet trigger dt dandavision/delta
zcomet trigger du bootandy/dust
zcomet trigger ll ogham/exa   
zcomet trigger fd sharkdp/fd
zcomet trigger l Peltoche/lsd
zcomet trigger ps dalance/procs
zcomet trigger rg BurntSushi/ripgrep
zcomet trigger battop bt svartalf/rust-battop
zcomet trigger sd chmln/sd

### Plugins zcomet trigger
zcomet load junegunn/fzf shell completion.zshf key-bindings.zsh
(( ${+commands[fzf]} )) || ~[fzf]/install --bin
zcomet load zsh-users/zsh-completions
zcomet load junegunn/fzf 
zcomet load marlonrichert/zcolors
zcomet load marlonrichert/zsh-autocomplete
zcomet load birdhackor/zsh-exa-ls-plugin
zcomet load hlissner/zsh-autopair
zcomet load mafredri/zsh-async
zcomet load sharkdp/vivid
zcomet load zdharma-continuum/history-search-multi-word
zcomet load dim-an/cod
zcomet load zsh-users/zsh-history-substring-search
zcomet load zsh-users/zsh-autosuggestions
zcomet load  zdharma-continuum/fast-syntax-highlighting

# History environment variables
HISTFILE=${ZDOTDIR}/zhistory
HISTSIZE=120000  
SAVEHIST=100000

# url-quote-magic & bracketed-paste-magic 
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# add a config file for ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

### make sure zsh-autosuggestions does't interfere ###
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete bracketed-paste accept-line push-line-or-edit)

# Cargo 
source "$HOME/.cargo/env"

# install neofetch-btw ###

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate snazzy)"

# cod
source <(cod init $$ zsh)

# p10k
source "$HOME/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme"
