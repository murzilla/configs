# Setup fzf
# ---------
if [[ ! "$PATH" == */home/murzilla/.fzf/bin* ]]; then
  export PATH="$PATH:/home/murzilla/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/murzilla/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/murzilla/.fzf/shell/key-bindings.bash"

