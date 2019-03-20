# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="/opt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
source /home/murzilla/.rvm/scripts/rvm
export TERM=xterm-256color

export PATH=$PATH:/usr/pgsql-9.6/bin
export PATH=$PATH:/usr/bin:/opt/cmake/bin
export CURL_INCLUDE_DIR=/usr/local/include/curl
export CURL_LIBRARY=/usr/lib64
export PROTOBUF_INCLUDE_DIR=/usr/local/include/google/protobuf
export LIBDIR=/usr/local/lib/:$LIBDIR
export LD_LIBRARY_PATH=$LIBDIR:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LIBDIR:/usr/local/lib:/usr/local/lib64
export CC=/bin/gcc
export CXX=/bin/g++
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export DEV=1

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\t":menu-complete'

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

function sshm {
    HOST=$1; ssh -i ~/.ssh/id_rsa_t2 -l murzilla $HOST;
}

# operations on blocks of code between matching patterns
function printblocks {
    echo "git grep -rl \"$1\" ${3:-.} | while read file; do echo \"$file:\"; sed -n -e \"/$1/,/$2/p;/^$2/q\" $file | cat -; done"
    grep -rl "$1" ${3:-.} | while read file; do echo "$file:"; sed -n -e "/$1/,/$2/p;/^$2/q" $file | cat -; done
}

function groupblocks {
    grep -rl "$1" ${3:-.} | while read file; do echo "$file"; sed -n -e "/$1/,/$2/p;/^$2/q" $file | awk '$1=$1'| md5sum -; done | paste -d " "  - - | awk '{col[$2]=col[$2]"\n"$1} END {for (i in col) print i, col[i], "\n"}'
    echo "Not found in:"
    grep -rL "$1" .
    #git grep -El "$1" | while read file; do echo -n "$file: "; sed -n -e "/$1/,/$2/{ p }" $file | awk '$1=$1'| md5sum -; done | paste -d " "  - - | awk '{col[$2]=col[$2]"\n"$1} END {for (i in col) print i, col[i]}'
}
function deleteblock {
    grep -rl "$1" ${3:-.} | while read file; do echo "$file"; perl -pi -e "BEGIN{undef $/;} s!$1.*?$2!!gsm" $file | cat -; done
}

# operations on subs in modules
function printsub {
    grep -rl "sub $1" ${2:-.} | while read file; do echo "$file:"; sed -n -e "/\<sub $1\>/,/^\}/{ p }" $file | cat -; done
}

function groupsub {
    grep -rl "sub $1" ${2:-.} | while read file; do echo "$file"; sed -n -e "/\<sub $1\>/,/^\}/{ p }" $file | awk '$1=$1'| md5sum -; done | paste -d " "  - - | awk '{col[$2]=col[$2]"\n"$1} END {for (i in col) print i, col[i], "\n"}'
    echo "Not found in:"
    grep -rL "sub $1"
}

function deletesub {
    grep -rl "sub $1" ${2:-.} | while read file; do echo "$file"; perl -pi -e "BEGIN{undef $/;} s!\bsub $1\b.*?^\}!!gsm" $file | cat -; done
}

function lf {
    ls --color=none -ptr | grep -v / | tail -n 1;
}
# cat /tmp/functions2.txt | while read -r line; do echo "========$line====="; groupsubs "$line"; printf "=======/$line======\n\n"; done
#function blocksmd5 {
#    git grep -El "$1" | while read file; do echo "$file:"; sed -n -e "/$1/,/$2/{ p }" $file | awk '$1=$1'| md5sum -; done
#}

#function countblocks {
#    git grep -El "$1" | while read file; do echo -n "$file: "; sed -n -e "/$1/,/$2/{ p }" $file | awk '$1=$1'| md5sum -; done | awk '{print $2}' | sort | uniq -c | sort -nr | head
#}

function cd {
  builtin cd "$@" && la
}
#echo "~/bashrc loaded"

source ~/perl5/perlbrew/etc/bashrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#Less options
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 -n'
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

export BAT_THEME=zenburn
export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'

export EDITOR=vim
export LESS_TERMCAP_so=$'\E[30;43m'

complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" sshm

