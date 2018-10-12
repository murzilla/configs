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

alias ll="ls -la --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al | tail -n+2'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -laSr'        # sort by size, biggest last
alias lj='ls -laS'         # sort by size, biggest last
alias lc='ls -latcr'       # sort by and show change time, most recent last
alias lu='ls -latur'       # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias lld='ll -d */'          # recursive ls
#alias conv='find . -name "*.html" -exec iconv -f ISO-8859-1 -t UTF-8 {} -o ../docs_utf/{} \;'
alias cddev='cd /opt/current' # cd dev
alias cdc='cd /opt/current' # cd dev
alias vimdev='vim /opt/current.task' # current task
alias vimrecon='vim /opt/current.recon' # current recon
#alias cdld='cd /opt/local_dev' # cd local_dev
alias cdhost='cd /opt/host' # cd local_dev
alias cdng='cd /usr/share/nginx' # cd nginx root
alias gulpc='gulp --require coffee-script/register' # cd nginx root
alias bejs='bundle exec jekyll serve' #--livereload
alias tn='tmux new -s dev' # new tmux session
alias ta='tmux attach -t dev' # attach tmux session
alias pgstart='docker run -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=pgpwd -d postgres'
#alias odoodb='docker run -p 5432:5432 -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres'
#alias odoostart='docker run -p 8069:8069 --name odoo --link db:db -t odoo'
alias pgcli='docker run -it --rm --link db:postgres postgres psql -h postgres -U odoo'
alias ptagit="ctags --options=/home/murzilla/.ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=local --exclude=.git --exclude='*~' --extras=q --languages=Perl --langmap=Perl:+.t"
alias jtagit="ctags --options=/home/murzilla/.ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --extras=q --languages=Javascript --langmap=Javascript:.js.es6.es.jsx.vue"
#alias ctagit="ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --extra=q --languages=Perl --langmap=Perl:+.t"
alias mockserver='docker run -it --init --rm --name mockserver -p 1080:1080 -p 1090:1090 jamesdbloom/mockserver /opt/mockserver/run_mockserver.sh -serverPort 1080 -genericJVMOptions "-Dmockserver.enableCORSForAllResponses=false"'
alias ag='ag --color-path=36'
alias cplack='carton exec plackup --no-default-middleware -R ./lib'
alias cperl='carton exec perl'
alias nonet='unshare -rn'
alias pllast='perlbrew use perl-5.26.1'
alias pl10='perlbrew use perl-5.10.1'

function txlog {
    TRX_ID=$1; mongo --quiet mongodb1.fixedandmobile.com/logs --eval "['3bill','topup'].forEach(function(coll){db[coll].find({trx_id:'$TRX_ID'}).limit(1).forEach(function(a){print(a.content)})})" | less
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
