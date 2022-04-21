alias
alias config='cd $HOME/.config'
alias bin='cd $HOME/.local/bin'
alias share='cd $HOME/.local/share'
alias rm='rm -rf'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mirror-update='sudo reflector --verbose -c Indonesia -c Japan -c Singapore --sort rate --save /etc/pacman.d/mirrorlist'
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias z='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>
alias sz='source ~/.zshrc'
alias ez='exec zsh'
alias ...='cd ../../'
alias ....='cd ../../../'
alias a2='aria2c -s16 -x16'
alias ..="cd .."
mcd () {
mkdir -p $1
cd $1
}
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias fm='ranger'
alias p="pacman -Q | fzf"
alias pac="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pi='sudo pacman -Syy'
alias prm='sudo pacman -Rns'
alias ps='sudo pacman -Ss'
alias yac='yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro  yay -S'
alias y='yay'
alias yi='yay -Syy'
alias yr="yay -Rns"
alias pr='paru --bottomup'
alias wifi="nmtui-connect"
alias ls="exa -la --group-directories-first --git --header --color-scale --color=always --icons"
alias l='lsd -la --group-dirs first --color always --icon always --blocks permission,user,size,date,name --date '+%d %b %y''
alias lt="exa --tree"
alias cat="bat --color always"
alias grep='rg'
alias v='nvim'
alias za='nvim $ZDOTDIR/core/aliases.zsh'
alias zf='nvim $ZDOTDIR/core/functions.zsh'
alias zrc='nvim $ZDOTDIR/.zshrc'
alias up='nmcli con up id'
alias down=' nmcli con down id'
alias vi='nvim'
alias vim='nvim'
alias n='nvim'
alias mv='mv -v'
alias cp='cp -vr'
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
alias off='sudo systemctl start poweroff.target'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias status='sudo systemctl status'
alias restart='sudo systemctl restart'
alias reboot='sudo systemctl start reboot.target'
fi
~
