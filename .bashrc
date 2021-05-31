# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH
PROMPT_COMMAND='history -a'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

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

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function gitmf {
    MF=$1; git st | grep modified: | awk '{print $2}' | sed -n $MF' p'
}

function jperl {
    (cd /current/jobs-script && cperl "$@")
}

function ccron {
    STR=$1; ag -l "$1" /current/jobs/ | sed 's/.*\///' | while read file; do ag $file /current/jobs/etc/crontab.production; done;
}

function sshm {
    HOST=$1; ssh -i ~/.ssh/id_rsa -l murat.baktiev $HOST;
}

function vimr {
    HOST=$1; vim scp://murat.baktiev@$HOST/$2;
}

function txlog {
    TRX_ID=$1; mongo --quiet mongodb1.fixedandmobile.com/logs --eval "rs.slaveOk(); ['3bill','topup'].forEach(function(coll){db[coll].find({action:'topup',trx_id:'$TRX_ID'}).limit(1).forEach(function(a){print(a.content)})})" | less | bat --language less --plain
}

function cd {
    builtin cd "$@" && la
}

complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" sshm
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" vimr

# operations on blocks of code between matching patterns
function printblocks {
    echo "grep -rl \"$1\" ${3:-.} | while read file; do echo \"$file:\"; sed -n -e \"/$1/,/$2/p;/^$2/q\" $file | cat -; done"
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

function lo {
    first_cmd=$1
    shift
    $first_cmd `lf` $@;
}

function vdiff {
    STR=$1; vimdiff "$STR" ~/$STR
}

function ndiff {
    STR=$1; diff "$STR" ~/$STR
}


#Less options
alias more='less'
export PAGER=less
export LESSCHARSET='utf-8'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
# Use this if lesspipe.sh exists
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
# my Less options
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 -iMSx4 -FXR -n'
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

export BAT_THEME=zenburn
export FZF_DEFAULT_COMMAND='ag --ignore local --ignore v1 --ignore langs -g ""'
export BAT_THEME="TwoDark"
export FZF_COMPLETION_OPTS="--preview '(bat --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export EDITOR=vim
export LESS_TERMCAP_so=$'\E[30;43m'

#export YELLOW=`echo -e '\033[1;33m'`
#export LIGHT_CYAN=`echo -e '\033[1;36m'`
#export NOCOLOR=`echo -e '\033[0m'`
#PAGER="sed \"s/\([[:space:]]\+[0-9.\-]\+\)$/${LIGHT_CYAN}\1$NOCOLOR/;"
#PAGER+="s/\([[:space:]]\+[0-9.\-]\+[[:space:]]\)/${LIGHT_CYAN}\1$NOCOLOR/g;"
#PAGER+="s/|/$YELLOW|$NOCOLOR/g;s/^\([-+]\+\)/$YELLOW\1$NOCOLOR/\" 2>/dev/null  | less"
#export PAGER

export GOROOT=/usr/local/go
export GOPATH=/opt/dev/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export EMAIL='murat.baktiev@gmail.com'

PATH="$PATH:/usr/pgsql-10/bin"
#eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

check_params() {
       if [[ $1 < $2 ]]; then
               echo -e "Usage:\n${3}"
               ok=0
       else
               ok=1
       fi
}

# detach all the clients from this session, and attach to it.
reattach_client() {
       check_params $# 1 "reattach_client <tmux_session_name>"
       if [[ $ok == 1 ]]; then
               tmux list-client | grep $1 | awk '{split($1, s, ":"); print s[1]}' | xargs tmux detach-client -t | true
               tmux attach -t $1
       fi
}
#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon


export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


check_params() {
       if [[ $1 < $2 ]]; then
               echo -e "Usage:\n${3}"
               ok=0
       else
               ok=1
       fi

}

# detach all the clients from this session, and attach to it.
reattach_client() {
       check_params $# 1 "reattach_client <tmux_session_name>"
       if [[ $ok == 1 ]]; then
               tmux list-client | grep $1 | awk '{split($1, s, ":"); print s[1]}' | xargs tmux detach-client -t | true
               tmux attach -t $1
       fi
}


# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true
