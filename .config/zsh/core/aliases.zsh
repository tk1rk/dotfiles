#!/usr/bin/env zsh

# General
alias config='cd $HOME/.config'
alias bin='cd $HOME/.local/bin'
alias share='cd $HOME/.local/share'
alias rm='rm -rf'
alias chx='chmod +x'
alias chr='sudo chown -R root:root'
alias cht='sudo chown -R tk:tk'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias a2='aria2c -s16 -x16'
alias l='exa -la --color=always --color-scale --icons'
alias lc='colorls -Ah --gs --sd --dark'
alias ls='lsd -la --group-dirs first --color always --icon always --blocks permission,user,size,date,name --date '+%d %b %y''
alias ip='curl ifconfig.me'
alias ez='exec zsh'
alias za='nvim $ZDOTDIR/include/aliases.zsh'
alias zf='nvim $ZDOTDIR/include/functions.zsh'
alias zrc='nvim $ZDOTDIR/zshrc'
alias vi='nvim'
alias vim='nvim'
alias randpass='openssl rand -base64 12 | tr -d '\n''
alias vb='VBoxManage'
alias vh='VBoxHeadless'
alias y='yarn'
alias ye='yarn exec'
# Interactive/verbose commands.
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'
# Auto-completion
alias up='nmcli con up id'
alias down=' nmcli con down id'
# arch linux with systemd aliases
if [[ '$LSB_DISTRIBUTOR' == 'inux' ]]; then
    # statements
    alias ctl='sudo systemctl '
    alias feierabend='sudo systemctl start poweroff.target'
    alias start='sudo systemctl start'
    alias stop='sudo systemctl stop'
    alias status='sudo systemctl status'
    alias restart='sudo systemctl restart'
    alias reboot='sudo systemctl start reboot.target'
fi
~
