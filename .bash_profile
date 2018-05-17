# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  echo "load ~/.bashrc"
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
echo "~/.bash_profile loaded"
