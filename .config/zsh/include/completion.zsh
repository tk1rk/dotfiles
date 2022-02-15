#!/usr/bin/env zsh

# Load more completions
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist

zle-line-init () {auto-fu-init;}
zle -N zle-line-init

a# cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE/.zcompcache"

# fish like Auto suggestion
autoload predict-on
predict-toggle() {
  ((predict_on=1-predict_on)) && predict-on || predict-off
}
zle -N predict-toggle
bindkey '^Z'   predict-toggle
zstyle ':predict' toggle true
zstyle ':predict' verbose true

## Now the fix, setup these two hooks: ###
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Load these ssh identities with the ssh module.
zstyle ':zim:ssh' ids 'id_rsa' 'id_ecdsa' 'id_ed25519'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true

# verbose
zstyle ':completion:*' verbose yes

# completer
zstyle ':completion:*' complete-options true

zstyle ':completion:*' use-perl true
zstyle :compinstall filename '$ZDOTDIR/.zshrc'

# Ignore useless files, like .pyc.
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/).pyc'

# Completing process IDs with menu selection.
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# fzf search display
zstyle ':completion:*' fzf-search-display true

# fzf-tab
zstyle ':fzf-tab:*' query-string prefix first
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'  # disable for tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 0 0

# git-checkout
zstyle ':completion:*:git-checkout:*' sort false

# exa
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false

history-words
​zstyle ​'​:completion:*:expand:*​' tag-order all-expansions            ​
​zstyle ​'​:completion:*:history-words​'​ list ​false​                          ​
​zstyle ​'​:completion:*:history-words​'​ menu yes                            
​zstyle ​'​:completion:*:history-words​'​ remove-all-dups yes                 
​zstyle ​'​:completion:*:history-words​'​ stop yes                            ​

# bash completions
source /etc/bash_completion