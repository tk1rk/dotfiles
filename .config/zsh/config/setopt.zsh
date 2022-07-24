#!/usr/bin/env zsh


setopt autocd              # change directory just by typing its name
setopt interactive_comments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt cdable_vars 
setopt check_jobs 
setopt correct 
setopt correct_all
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt auto_menu                # Show Completion Menu On A Successive Tab Press.
setopt auto_param_slash         # If Completed Parameter Is A Directory, Add A Trailing Slash.
setopt no_complete_aliases
unsetopt flow_control           # Disable Start/Stop Characters In Shell Editor.

# History.
HISTFILE="$HOME/.cache/zsh/.zhistory"
HISTSIZE=100000
SAVEHIST=120000
unsetopt beep nomatch
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with s*|pace
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_reduce_blanks	 # Remove superfluous blanks from history items.
setopt hist_find_no_dups	  # Do Not Display A Previously Found Event.
setopt hist_save_no_dups	  # Do Not Write A Duplicate Event To The History File.
setopt append_history	     # Allow multiple terminal sessions to all append to one zsh command history.
setopt extended_history	   # Show Timestamp In History.
setopt inc_append_history	 # Write To The History File Immediately, Not When The Shell Exits.
setopt bang_hist	          # Treat The '!' Character Specially During Expansion.
setopt multios	            # Perform implicit tees or cats when multiple redirections are attempted.
setopt pushd_ignore_dups	  # Don't push multiple copies of the same directory onto the directory stack.
setopt pushdminus	         # Swapped the meaning of cd +1 and cd -1; we want them to mean the opposite of what they
