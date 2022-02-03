#!/usr/bin/env zsh

### ZSH SOURCES ###
typeset -ga sources
for file in "${ZSH}/bindkeys.zsh" \
            "${ZSH}/functions.zsh" \
            "${ZSH}/aliases.zsh" \
            "${ZSH}/completion.zsh" \
            "${ZDOTDIR}/plugins/find-the-command/ftc.zsh" 
do
    [ -s "${file}" ] && source "${file}"
done

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

# Source zcomet.zsh
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# bash completion
autoload -U +X bashcompinit && bashcompinit

# Load a prompt
zcomet load romkatv/powerlevel10k

# Lazy-load some plugins
zcomet trigger zhooks agkozak/zhooks
zcomet trigger zsh-prompt-benchmark romkatv/zsh-prompt-benchmark

# Helps zinit select correct remote binaries
case "$OSTYPE" in
  linux*) bpick='*((#s)|/)*(linux|musl)*((#e)|/)*' ;;
  darwin*) bpick='*(macos|darwin)*' ;;
  *) echo 'WARN: unsupported system -- some cli programs might not work' ;;
esac

# colors
autoload -U colors; colors

# OMZL Shorthand Syntax
zcomet load ohmyzsh lib cli.zsh
zcomet load ohmyzsh lib clipboard.zsh 
zcomet load ohmyzsh lib compfix.zsh 
zcomet load ohmyzsh lib completion.zsh 
zcomet load ohmyzsh lib correction.zsh 
zcomet load ohmyzsh lib directories.zsh
zcomet load ohmyzsh lib functions.zsh
zcomet load ohmyzsh lib git.zsh 
zcomet load ohmyzsh lib grep.zsh 
zcomet load ohmyzsh lib history.zsh
zcomet load ohmyzsh lib key-bindings.zsh 
zcomet load oh.yzsh lib prompt-info-functions.zsh
zcomet load ohmyzsh lib spectrum.zsh 
zcomet load ohmyzsh lib termsupport.zsh 

## omzp snippets
zcomet load ohmyzsh plugins/cargo
zcomet load ohmyzsh plugins/colored-man-pages
zcomet load ohmyzsh plugins/command-not-found
zcomet load ohmyzsh plugins/direnv
zcomet load ohmyzsh plugins/docker
zcomet load ohmyzsh plugins/docker-compose
zcomet load ohmyzsh plugins/extract
zcomet load ohmyzsh plugins/fzf
zcomet load ohmyzsh plugins/gitfast
zcomet load ohmyzsh plugins/history
zcomet load ohmyzsh plugins/history-sunstring-search
zcomet load ohmyzsh plugins/rbenv
zcomet load ohmyzsh plugins/ripgrep
zcomet load ohmyzsh plugins/ruby
zcomet load ohmyzsh plugins/rustup

### Programs 
zcomet trigger bat sharkdp/bat
zcomet trigger top /battop
zcomet trigger exa ogham/exa
zcomet trigger fd sharkdp/fd
zcomet trigger ll Peltoche/lsd
zcomet trigger rg BurntSushi/ripgrep
zcomet trigger z skywind3000/z.lua



# Lazy-load Prezto's archive module without downloading all of Prezto's
# submodules
zcomet trigger --no-submodules archive unarchive lsarchive \
    sorin-ionescu/prezto modules/archive

### Plugins
zcomet load marlonrichert/zcolors
zcomet load marlonrichert/zsh-autocomplete
zcomet load birdhackor/zsh-exa-ls-plugin
zcomet load hlissner/zsh-autopair
zcomet load mafredri/zsh-async
zcomet load Alaxof/fzf-tab
zcomet load sharkdp/vivid
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
  eval "$(dircolors -b)"
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  export CLICOLOR=1
  zstyle ':completion:*' list-colors ''
fi

### Cargo ###
source "$HOME/.cargo/env"

### Neofetch ###
neofetch

# LS_COLORS (vivid)
export LS_COLORS="$(vivid generate snazzy)"

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
