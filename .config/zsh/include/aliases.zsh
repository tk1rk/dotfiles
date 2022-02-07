# General
alias python='python3'
alias pip='pip3'
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
alias ls='lsd -la

# Quick typing
alias n1ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip='curl ifconfig.me'  
alias n1ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias n1sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias n1httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias ez='exec zsh'                           
alias za='nvim $HOME/zsh/aliases.zsh'         
alias zf='nvim $HOME/zsh/functions.zsh'         
alias zrc='nvim $HOME/.zshrc'                         
alias vi='nvim'
alias vim='nvim'

alias nerdcrap='bat /dev/urandom | xxd | grep --color=never --line-buffered "be ef"'
alias pt='pstree -pul'
alias randnum='python -S -c "import random; print(random.SystemRandom().randrange(10**7,10**8))"'
alias randpass="openssl rand -base64 12 | tr -d '\n'"

alias rsync-usual='rsync -azv -e ssh --delete --progress'
alias scp='scp -C -p'
alias screen='screen -U'
alias slurp='wget -t 5 -c -nH -r -k -p -N --no-parent'
alias tt='tail -n 9999'
alias vb=VBoxManage
alias vh=VBoxHeadless
alias whois='whois -h geektools.com'
alias wip='git add -A ; git commit --all --no-verify -m WIP'
alias y='yarn'
alias ye='yarn exec'

# Interactive/verbose commands.
alias mv='mv -i'
for c in cp rm chmod chown rename; do
  alias $c="$c -v"
done

# Use GNU du if available
if _has gdu; then
  alias du=gdu
  dut() { du -a -h --exclude=.git $@ * .* | sort -rh | head -n 20 }
else
  dut() { du -h $@ * .* | sort -rh | head -n 20 }
fi

# open command for linux
if ! _has open && _has xdg-open; then
  alias open=xdg-open
fi
, 
# Humanize disk space if possible
if _try df -H ~; then
  alias df='df -H'
elif _try df -h ~; then
  alias df='df -h'
fi



# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# Auto-completion
alias up=" nmcli con up id"
alias down=" nmcli con down id"

# arch linux with systemd aliases
if [[ "$LSB_DISTRIBUTOR" == "archlinux" ]]; then
    # statements
    alias ctl='sudo systemctl '
    alias feierabend='sudo systemctl start poweroff.target'
    alias start=" sudo systemctl start"
    alias stop=" sudo systemctl stop"
    alias status=" sudo systemctl status"
    alias restart=" sudo systemctl restart"
    alias reboot="sudo systemctl start reboot.target"
fi
