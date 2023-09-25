#!/usr/bin/env bash
swayidle -w timeout 300 lockscreen.sh \
    timeout 360 suspend.sh \
    resume resume.sh \
    before-sleep lockscreen.sh \
    after-resume resume.sh

exec = lid.sh 
bindl = ,switch:Lid Switch,exec,lid.sh
