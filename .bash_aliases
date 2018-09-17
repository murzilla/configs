shopt -s expand_aliases
alias ll="ls -la --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
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
alias mockserver='docker run --rm --name mockserver -p 1080:1080 -p 1090:1090 jamesdbloom/mockserver'
alias ag='ag --color-path=36'
alias plack='carton exec plackup --no-default-middleware -R ./lib'
alias cperl='carton exec perl'
alias nonet='unshare -r -n'
