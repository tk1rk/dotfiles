swayidle -w \
    timeout 300 'swaylock-fancy-rapid 7 3' \      
    timeout 600 'swaymsg "output * dpms off"' \ 
    resume 'swaymsg "output * dpms on"' \
    before-sleep 'swaylock-fancy-rapid 7 3'
