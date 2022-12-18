
#################################################################
# INSTALL `zinit` AND LOAD IT
#

# Install `zinit` if not installed
if [ ! -d "${HOME}/.zinit" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

# Load `zinit`
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


#################################################################
# FUNCTIONS TO MAKE CONFIGURATION LESS VERBOSE
#

turbo0()   { zinit ice wait"0a" lucid             "${@}"; }
turbo1()   { zinit ice wait"0b" lucid             "${@}"; }
turbo2()   { zinit ice wait"0c" lucid             "${@}"; }
zcommand() { zinit ice wait"0b" lucid as"command" "${@}"; }
zload()    { zinit load                           "${@}"; }
zsnippet() { zinit snippet                        "${@}"; }

#################################################################
# FUZZY SEARCH AND MOVEMENT
#
# Install a fuzzy finder (fzf/fzy) and necessary completions
# and key bindings.
#

# Install `fzf` bynary and tmux helper script
zcommand from"gh-r";         zload junegunn/fzf-bin
zcommand pick"bin/fzf-tmux"; zload junegunn/fzf
# Create and bind multiple widgets using fzf
turbo0 multisrc"shell/{completion,key-bindings}.zsh" \
        id-as"junegunn/fzf_completions" pick"/dev/null"
    zload junegunn/fzf

# Fuzzy movement and directory choosing
turbo1; zload rupa/z               # autojump command
turbo0; zload andrewferrier/fzf-z  # Pick from most frecent folders with `Ctrl+g`
turbo0; zload changyuheng/fz       # lets z+[Tab] and zz+[Tab]

# Like `z` command, but opens a file in vim based on frecency
zcommand pick"v"; zload rupa/v

# Install `fzy` fuzzy finder, if not yet present in the system
# Also install helper scripts for tmux and dwtm
turbo0 as"command" if'[[ -z "$commands[fzy]" ]]' \
       make"!PREFIX=$ZPFX install" atclone"cp contrib/fzy-* $ZPFX/bin/" pick"$ZPFX/bin/fzy*"
    zload jhawthorn/fzy
# Install fzy-using widgets
turbo0 silent; zload aperezdc/zsh-fzy
bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget

# Fuzzy search by `Ctrl+P` a file and open in `$EDITOR`
# Implements it's own fuzzy search
turbo0; zload mafredri/zsh-async
turbo0; zload seletskiy/zsh-fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
export EDITOR=${EDITOR:-nvim}



#################################################################
# INSTALL `k` COMMAND AND GENERATE COMPLITIONS
#
turbo0; zload RobSis/zsh-completion-generator
turbo1 atclone"gencomp k; ZINIT[COMPINIT_OPTS]='-i' zpcompinit" atpull'%atclone'
    zload supercrabtree/k
alias l='k -h'


#################################################################
# OTHER PLUGINS
#

# Add `git dsf` command to git
zcommand pick"bin/git-dsf";            zload zdharma/zsh-diff-so-fancy

# Add command-line online translator
turbo1 if'[[ -n "$commands[gawk]" ]]'; zload soimort/translate-shell

# `...` ==> `../..`
# turbo2 pick"manydots-magic";           zload knu/zsh-manydots-magic

# Toggles "sudo" before the current/previous command by pressing ESC-ESC.
turbo1; zload hcgraf/zsh-sudo

# Run `fg` command to return to foregrounded (Ctrl+Z'd) vim
turbo1; zload mdumitru/fancy-ctrl-z

# Install gitcd function to clone git repository and cd into it
turbo1; zload lainiwa/gitcd
export GITCD_TRIM=1
export GITCD_HOME=${HOME}/tmp


#################################################################
# INSTALL/SOURCE LOCAL STUFF
#

# Install completions for `my` script and for python-gist
# (use `-f` flag to force completion installation)
zinit ice as"completion" if"[ -f '${HOME}/.zsh/completions/_my' ]" id-as"my";
    zsnippet "${HOME}/.zsh/completions/_my"

turbo0 as"completion" if"[ -f '${HOME}/.local/share/gist/gist.zsh' ]" id-as"gist" mv"gist.zsh -> _gist";
    zsnippet "${HOME}/.local/share/gist/gist.zsh"


#################################################################
# IMPORTANT PLUGINS
#

# Additional completion definitions
turbo0 blockf
zload zsh-users/zsh-completions

# History search by `Ctrl+R`
turbo1; zload zdharma/history-search-multi-word

# Syntax highlighting
# (compinit without `-i` spawns warning on `sudo -s`)
turbo0 atinit"ZINIT[COMPINIT_OPTS]='-i' zpcompinit; zpcdreplay"
    zload zdharma/fast-syntax-highlighting

# Autosuggestions
# Note: should go _after_ syntax highlighting plugin
turbo0 atload"_zsh_autosuggest_start"; zload zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1


#################################################################
# REMOVE TEMPORARY FUNCTIONS
#
unset -f turbo0
unset -f zload
unset -f zsnippet
