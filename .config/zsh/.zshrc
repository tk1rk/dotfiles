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

# Helps zinit select correct remote binaries
case "$OSTYPE" in
  linux*) bpick='*((#s)|/)*(linux|musl)*((#e)|/)*' ;;
  darwin*) bpick='*(macos|darwin)*' ;;
  *) echo 'WARN: unsupported system -- some cli programs might not work' ;;
esac

# PZ
PZ_PLUGIN_HOME="${ZDOTDIR:-~/.config/zsh}/plugins"
[[ -d $PZ_PLUGIN_HOME/pz ]] ||
  git clone https://github.com/mattmc3/pz.git $PZ_PLUGIN_HOME/pz
source $PZ_PLUGIN_HOME/pz/pz.zsh

# source plugins from github
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-history-substring-search
pz source zsh-users/zsh-completions
pz source zsh-users/zsh-syntax-highlightin

# source ohmyzsh plugins
pz source ohmyzsh/ohmyzsh plugins/colored-man-pages

# set your prompt
pz prompt sindresorhus/pure

# -or- use oh-my-zsh themes instead of a prompt plugin
pz source ohmyzsh lib/git
pz source ohmyzsh lib/theme-and-appearance
pz source ohmyzsh themes/robbyrussell

# Theme
pz prompt romkatv/powerlevel10k

# Lazy-load some plugins
zcomet trigger zhooks agkozak/zhooks
zcomet trigger zsh-prompt-benchmark romkatv/zsh-prompt-benchmark

# OMZL Shorthand Syntax
pz source ohmyzsh lib cli.zsh
pz source ohmyzsh lib clipboard.zsh 
pz source ohmyzsh lib compfix.zsh 
pz source ohmyzsh lib completion.zsh 
pz source ohmyzsh lib correction.zsh 
pz source ohmyzsh lib directories.zsh
pz source ohmyzsh lib functions.zsh
pz source ohmyzsh lib git.zsh 
pz source ohmyzsh lib grep.zsh 
pz source ohmyzsh lib history.zsh
pz source ohmyzsh lib key-bindings.zsh 
pz source oh.yzsh lib prompt-info-functions.zsh
pz source ohmyzsh lib spectrum.zsh 
pz source ohmyzsh lib termsupport.zsh 

## omzp snippets
pz source ohmyzsh plugins/cargo
pz source ohmyzsh plugins/colored-man-pages
pz source ohmyzsh plugins/command-not-found
pz source ohmyzsh plugins/direnv
pz source ohmyzsh plugins/docker
pz source ohmyzsh plugins/docker-compose
pz source ohmyzsh plugins/extract
pz source ohmyzsh plugins/fzf
pz source ohmyzsh plugins/gitfast
pz source ohmyzsh plugins/history
pz source ohmyzsh plugins/history-sunstring-search
pz source ohmyzsh plugins/rbenv
pz source ohmyzsh plugins/ripgrep
pz source ohmyzsh plugins/ruby
pz source ohmyzsh plugins/rustup

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




# Lazy-load Prezto's archive module without downloading all of Prezto's
# submodules
zcomet trigger --no-submodules archive unarchive lsarchive \
    sorin-ionescu/prezto modules/archive

### Plugins
zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh
(( ${+commands[fzf]} )) || ~[fzf]/install --bin
zcomet load marlonrichert/zcolors
zcomet load marlonrichert/zsh-autocomplete
zcomet load birdhackor/zsh-exa-ls-plugin
zcomet load hlissner/zsh-autopair
zcomet load mafredri/zsh-async
zcomet load lincheney/fzf-tab-completion
zcomet load sharkdp/vivid
zcomet load z-shell/zredis
zcomet load hangyuheng/zsh-interactive-cd
zcomet load zdharma-continuum/zredis
zcomet load zdharma-continuum/zui
zcomet load zdharma-continuum/zsh-diff-so-fancy
zcomet load zdharma-continuum/history-search-multi-word
zcomet load zsh-users/zsh-history-substring-search
zcomet load zsh-users/zsh-autosuggestions
zcomet load zdharma-continuum/fast-syntax-highlighting

# Run compinit and compile its cache
zcomet compinit

# History environment variables
HISTFILE=${HOME}/.zsh_history
HISTSIZE=120000  # Larger than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work
SAVEHIST=100000

### load url-quote-magic and bracketed-paste-magic ###
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# add a config file for ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.rgrwc"

### make sure zsh-autosuggestions does't interfere ###
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete bracketed-paste accept-line push-line-or-edit)

### .dircolors ###
if whence dircolors >/dev/null; then
  eval "$(dircolors -b $HOME/.dircolors)"
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  export CLICOLOR=1
fi

### Cargo Source && Rustup Completion ###
source "$HOME/.cargo/env"
rustup completions zsh > $ZSH_COMPLETIONS/_rustup
export RUSTFLAGS="-C target-cpu = native" cargo build --release --features

### Neofetch ###
neofetch



# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate snazzy)"

# zredis
source "${ZSH_PLUGINS}/zredis/zredis.plugin.zsh"

### z.lua & czmod module
export _ZL_DATA='$ZSH_PLUGINS/z.lua/'
export _ZL_ADD_ONCE=1
export _ZL_CD='exa --long -all --header --git --icons --color=always --color-scale'
export _ZL_ECHO=1
export _ZL_MATCH_MODE=1
export _ZL_USE_LFS=1
export _ZL_HYPHEN=1
eval "$(lua /path/to/z.lua --init zsh enhanced once echo fzf)"
source "$ZSH_PLUGINS/z.lua/czmod/czmod.zsh"
