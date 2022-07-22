#!/usr/bin/env sh
# vim: sw=2 ts=2 et! 

auto-ls () { 
  if [[ $#BUFFER -eq 0 ]]; then 
    zle && echo "" 
    exa -la --header --git --group-directories-first --icons --color=always --color-scale --no-time 
    echo "" 
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then 
      git status 
    fi 
 
    zle && zle redisplay 
  else 
    zle .$WIDGET 
  fi 
} 
  
 zle -N auto-ls 
 zle -N accept-line auto-ls 
 chpwd_functions+=(auto-ls)
