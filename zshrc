typeset -F SECONDS
shell_start=$SECONDS

# timer functions
_last_recorded_time=$shell_start
record_time() {
  local next_time=$SECONDS
  local line="$(printf "%d" $((($next_time - $_last_recorded_time) * 1000)))\t$1"
  _last_recorded_time=$next_time
  _recorded_times="$_recorded_times\n$line"
}

print_recorded_times() {
  echo "$_recorded_times" | sort -nr
}

record_time "setup"

source $HOME/.anyshell/paths
record_time "paths"

source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
record_time "syntax-highlighting"

source $HOME/.zsh/config
record_time "config"
source $HOME/.zsh/prompt
record_time "prompt"
source $HOME/.zsh/completion
record_time "completion"
source $HOME/.anyshell/aliases
record_time "aliases"
source $HOME/.anyshell/functions
record_time "functions"

# "z" script
z_script="/usr/local/etc/profile.d/z.sh"
[[ -f $z_script ]] && source $z_script
record_time "z"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
record_time "local"

# Enable RVM
export rvm_path="$HOME/.rvm"
[[ -s $rvm_path/scripts/rvm ]] && source $rvm_path/scripts/rvm
# clean up after it
dedup_pathvar PATH
record_time "rvm"

# Use FZF
source ~/.fzf.zsh
record_time "fzf"

# Initial tmux window name
tmux-set-window-name
record_time "tmux-set-window-name"

echo "Started up in $(printf "%d" $(($SECONDS * 1000)))ms"
print_recorded_times
