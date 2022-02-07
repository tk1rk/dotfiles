#!/bin/zsh

# 16.2.1 Changing Directories {{{2

setopt AUTO_CD            # Change to a directory just by typing its name
setopt AUTO_PUSHD         # Make cd push each old directory onto the stack
setopt CDABLE_VARS        # Like AUTO_CD, but for named directories
setopt PUSHD_IGNORE_DUPS  # Don't push duplicates onto the stack


# Set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP

# Share your history across all your terminal windows
setopt share_history
#setopt nocl

# Set some options about directories
setopt pushd_ignore_dups
#setopt pushd_silent

# Add some completions settings
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_MENU         # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
setopt CORRECT
setopt NO_LIST_BEEP       # Don't beep on an ambiguous completion
setopt LIST_PACKED        # Use columns of varying widths
unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.

# Miscellaneous settings
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.

setopt extended_glob # Enable more powerful glob features
