#!/usr/bin/env zsh


parufind () {
    paru -Sl | awk '{print $2($4=="" ? "" : " \*")}' | fzf -q "$1" -m --preview 'cat <(echo {1} | cut -d " " -f 1 | paru -Si -) <(echo {1} | cut -d " " -f 1 | paru -Fl - | awk "{print $2}")' | cut -d " " -f 1 | xargs -ro paru -S
}

pacfind () {
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

yayfind () {
    yay -Sl | awk '{print $2($4=="" ? "" : " *")}' | fzf --multi --preview 'yay -Si {1}' --reverse | xargs -ro yay -Si
}
