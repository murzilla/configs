# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

export PATH="$HOME/.cargo/bin:$PATH"
export VISUAL="vim"
export EDITOR="vim"
export REVIEW_BASE="master"
