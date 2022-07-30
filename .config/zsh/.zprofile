if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    # pgrep bspwm || ([[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null)
    # pgrep bspwm || ( exec startx -- vt1 &> /dev/null)
    pgrep bspwm || ( exec startx &> /dev/null) && logout
fi
