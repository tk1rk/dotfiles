#!/bin/zsh

# Changing Directories  
setopt AUTO_CD                                                      # Change to a directory just by typing its name
setopt AUTO_PUSHD                                                   # Make cd push each old directory onto the stack
setopt AUTO_LIST                                                    # Automatically list choices on ambiguous completion.
setopt CDABLE_VARS                                                  # Like AUTO_CD, but for named directories
setopt PUSHD                                                        # Make cd push the old directory onto the directory stack.
setopt promptsubst	                                                # Enables the substitution of parameters inside the prompt each time the prompt is drawn.
# History optimization
setopt hist_ignore_all_dups	                                        # Remove older duplicate entries from history.
setopt hist_expire_dups_first	                                    # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups	                                            # Do Not Record An Event That Was Just Recorded Again.
setopt hist_reduce_blanks	                                        # Remove superfluous blanks from history items.
setopt hist_find_no_dups	                                        # Do Not Display A Previously Found Event.
setopt hist_ignore_space	                                        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups	                                        # Do Not Write A Duplicate Event To The History File.
setopt hist_verify	                                                 # Do Not Execute Immediately Upon History Expansion.
setopt append_history	                                            # Allow multiple terminal sessions to all append to one zsh command history.
setopt extended_history	                                            # Show Timestamp In History.
setopt inc_append_history	                                        # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history	                                            # Share history between different instances of the shell
# Add some completions settings
setopt ALWAYS_TO_END                                                # Move cursor to the end of a completed word.
setopt AUTO_LIST                                                    # Automatically list choices on ambiguous completion.
setopt AUTO_MENU                                                    # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH                                             # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD                                             # Complete from both ends of a word.
setopt CORRECT
setopt NO_LIST_BEEP                                                 # Don't beep on an ambiguous completion
setopt no_beep	                                                    # Don't beep on error.
setopt LIST_PACKED                                                  # Use columns of varying widths
unsetopt MENU_COMPLETE                                              # Do not autoselect the first completion entry.
# Miscellaneous settings
setopt INTERACTIVE_COMMENTS                                         # Enable comments in interactive shell.                           
setopt extended_glob                                                # Enable more powerful glob features
