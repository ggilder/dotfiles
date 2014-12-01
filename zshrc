typeset -F SECONDS

source $HOME/.anyshell/paths

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# Disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(osx zsh-syntax-highlighting)

source $HOME/.zsh/config
source $HOME/.zsh/prompt
source $HOME/.zsh/completion
source $HOME/.anyshell/aliases
source $HOME/.anyshell/functions

# "z" script
z_script="/usr/local/etc/profile.d/z.sh"
[[ -f $z_script ]] && source $z_script

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

# Enable RVM
export rvm_path="$HOME/.rvm"
[[ -s $rvm_path/scripts/rvm ]] && source $rvm_path/scripts/rvm
# clean up after it
dedup_pathvar PATH

# Use FZF
source ~/.fzf.zsh

# Initial tmux window name
tmux-set-window-name

echo "Started up in ${SECONDS}s"
