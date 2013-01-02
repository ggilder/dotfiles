#echo "=> Loading `pwd`/bash_profile"

source ~/.anyshell/paths
source ~/.bash/config
source ~/.anyshell/aliases
source ~/.anyshell/functions

# Load in .bashrc
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
source ~/.bash/colors
source ~/.bash/prompt

export rvm_path="$HOME/.rvm"
# Enable RVM
[[ -s $rvm_path/scripts/rvm ]] && source $rvm_path/scripts/rvm
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X, 
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started 
# (when you run "bash" from inside a shell, or when you start a shell in 
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed, 
# in this order:
#     bashrc
#     .bashrc
