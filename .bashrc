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
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -laSr'         # sort by size, biggest last
alias lj='ls -laS'         # sort by size, biggest last
alias lc='ls -latcr'        # sort by and show change time, most recent last
alias lu='ls -latur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias lld='ll -d */'          # recursive ls
#alias conv='find . -name "*.html" -exec iconv -f ISO-8859-1 -t UTF-8 {} -o ../docs_utf/{} \;'
alias cddev='cd /opt/current' # cd dev
alias vimdev='vim /opt/current.task' # cd dev
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
alias ptagit="ctags --options=/home/murzilla/.ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=local --exclude=.git --exclude='*~' --extras=* --languages=Perl --langmap=Perl:+.t"
alias jtagit="ctags --options=/home/murzilla/.ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --extras=q --languages=Javascript --langmap=Javascript:.js.es6.es.jsx.vue"
#alias ctagit="ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --extra=q --languages=Perl --langmap=Perl:+.t"
alias mockserver='docker run --rm --name mockserver -p 1080:1080 -p 1090:1090 jamesdbloom/mockserver'
alias ag='ag --color-path=36'
alias plack='carton exec plackup --no-default-middleware -R ./lib'
alias cperl='carton exec perl'

function cd {
  builtin cd "$@" && ll
}
echo "~/bashrc loaded"

source ~/perl5/perlbrew/etc/bashrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export EDITOR=vim
