source $HOME/.anyshell/paths
source $HOME/.zsh/config
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
