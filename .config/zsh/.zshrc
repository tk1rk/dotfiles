#!/usr/bin/env zsh

### ZSH SOURCES ###
typeset -ga sources
for file in "${ZDOTDIR}/bindkeys.zsh" \
            "${ZDOTDIR}/functions.zsh" \
            "${ZDOTDIR}/aliases.zsh" \
            "${ZDOTDIR}/completion.zsh" \
            "${ZDOTDIR}/setopt.zsh" \
            "${ZDOTDIR}/less.zsh" \
            "${ZDOTDIR}/plugins/find-the-command/ftc.zsh" 
do
    [ -s "${file}" ] && source "${file}"
done

# bash completion
autoload -U +X bashcompinit && bashcompinit

# colors
autoload -U colors; colors

# PZ
PZ_PLUGIN_HOME="${ZDOTDIR:-~/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh

# Theme
pz prompt romkatv/powerlevel10k

# source ohmyzsh plugins
pz source ohnyzsh lib/compfix.zsh 
pz source ohmyzsh lib/completion.zsh 
pz source ohmyzsh lib/correction.zsh 
pz source ohmyzsh lib/functions.zsh
pz source ohmyzsh lib/git.zsh
pz source ohmyzsh lib/termsupport.zsh 
pz source ohmyzsh lib/theme-and-appearance

# omzp snippets
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages
pz source ohmyzsh/ohmyzsh plugins/command-not-found
pz source ohmyzsh/ohmyzsh plugins/direnv
pz source ohmyzsh/ohmyzsh plugins/docker
pz source ohmyzsh/ohmyzsh plugins/docker-compose
pz source ohmyzsh/ohmyzsh plugins/extract
pz source ohmyzsh/ohmyzsh plugins/fzf
pz source ohmyzsh/ohmyzsh plugins/ripgrep
pz source ohmyzsh/ohmyzsh plugins/rust

### Programs 
pz source sharkdp/bat 
pz source svartalf/rust-battop bt
pz source ogham/exa ls
pz source sharkdp/fd fd
pz source Peltoche/lsd l
pz source BurntSushi/ripgrep rg
pz source dalance/procs ps
pz source chmln/sd
pz source bootandy/dust du

### Plugins

# source plugins from github
pz source zsh-users/zsh-completions
pz source junegunn/fzf 
pz source marlonrichert/zcolors
pz source marlonrichert/zsh-autocomplete
pz source birdhackor/zsh-exa-ls-plugin
pz source hlissner/zsh-autopair
pz source mafredri/zsh-async
pz source sharkdp/vivid
pz source zdharma-continuum/history-search-multi-word
pz source zsh-users/zsh-history-substring-search
pz source zsh-users/zsh-autosuggestions
pz source zdharma-continuum/fast-syntax-highlighting

# History environment variables
HISTFILE=${ZDOTDIR}/.zhistory
HISTSIZE=120000  # Larger than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work
SAVEHIST=100000

### load url-quote-magic and bracketed-paste-magic ###
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
