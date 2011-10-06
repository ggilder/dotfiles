source $HOME/.anyshell/paths
source $HOME/.zsh/config

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(osx zsh-syntax-highlighting)

source $HOME/.zsh/prompt
source $HOME/.zsh/completion
source $HOME/.anyshell/aliases
source $HOME/.anyshell/functions

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

# Enable RVM
export rvm_path="$HOME/.rvm"
[[ -s $rvm_path/scripts/rvm ]] && source $rvm_path/scripts/rvm
# __rvm_project_rvmrc # only necessary for iTerm?
