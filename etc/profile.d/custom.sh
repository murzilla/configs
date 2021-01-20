bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\t":menu-complete'

export HISTTIMEFORMAT='%y-%m-%d %T '
export CDPATH=.:/current/
export MC_SKIN=/home/murzilla/.mc/solarized.ini
PROMPT_COMMAND='history -a'


