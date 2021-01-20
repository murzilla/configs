shopt -s expand_aliases
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
alias ll="ls -lahtr --group-directories-first"
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias lld='ll -d */'          # recursive ls
#alias conv='find . -name "*.html" -exec iconv -f ISO-8859-1 -t UTF-8 {} -o ../docs_utf/{} \;'
alias cddev='cd /opt/current' # cd dev
alias cdc='cd /current' # cd dev
alias vimdev='vim /opt/current.task' # current task
alias vimrecon='vim /opt/current.recon' # current recon
#alias cdld='cd /opt/local_dev' # cd local_dev
alias cdhost='cd /opt/host' # cd local_dev
alias cdng='cd /usr/share/nginx' # cd nginx root
alias gulpc='gulp --require coffee-script/register' # cd nginx root
alias bejs='bundle exec jekyll serve' #--livereload
alias tn='tmux new-session -A -s dev' # new tmux session
alias ts='tmux new-session -A -s sql' # new tmux session
#alias tl='tmux new -s log' # new tmux session
#alias ts='tmux new -s sql' # new tmux session
#alias ta='tmux attach -t dev' # attach tmux session
#alias tal='tmux attach -t log' # attach tmux session
#alias tas='tmux attach -t sql' # attach tmux session
alias pgstart='docker run -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=pgpwd -d postgres:10.11'
alias rdstart='docker run -p 6379:6379 --name redis -d redis redis-server --appendonly yes'
#alias odoodb='docker run -p 5432:5432 -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres'
#alias odoostart='docker run -p 8069:8069 --name odoo --link db:db -t odoo'
#alias pgcli='docker run -it --rm --link db:postgres postgres psql -h postgres -U odoo'
alias pgcli='PGPASSWORD=pgpwd psql -h localhost -U postgres'
#alias ptagit="ctags --options=/home/murzilla/.ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=local --exclude=.git --exclude='*~' --tag-relative=yes --extras=+q --languages=Perl --langmap=Perl:+.t"
alias ptagit="ctags --options=/home/murzilla/.ctags2.cnf --append=no -f .tags --recurse --totals --exclude=blib --exclude=local --exclude=.git --exclude='*~' --tag-relative=yes --languages=Perl --langmap=Perl:+.t"
alias jtagit="ctags --options=/home/murzilla/.ctags2.cnf --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --tag-relative=yes --languages=Javascript --langmap=Javascript:.js.es6.es.jsx.vue"
#alias ctagit="ctags --append=no -f .tags --recurse --totals --exclude=blib --exclude=.git --exclude='*~' --extra=q --languages=Perl --langmap=Perl:+.t"
alias mockserver='docker run -it --init --rm --name mockserver -p 1080:1080 -p 1090:1090 jamesdbloom/mockserver /opt/mockserver/run_mockserver.sh -serverPort 1080 -genericJVMOptions "-Dmockserver.enableCORSForAllResponses=false"'
alias ag='ag --color-path=36 --ignore v1'
alias cplack='carton exec plackup --no-default-middleware -R ./lib'
alias start_report='(cd /current/report/local-dev && cplack -R ../modules  -R ../cgi-bin local-server.psgi)'
alias start_minion='(cd /current/queue && cperl gui.pl daemon)'
alias cperl='carton exec perl'
alias nonet='unshare -r -n'
alias pllast='perlbrew use perl-5.26.1'
alias pl10='perlbrew use perl-5.10.1'
alias dit='docker exec -it '
alias mc='mc -c --nosubshell'
#alias mc2='mc -c'
alias bc='bc -l'
alias dpromalert='docker-compose -f prometheus-server/docker-compose.yaml -f alertmanager-server/docker-compose.yaml'
alias cleanswp=$'find . -name "*.sw[p|o]" -exec rm -rf \'{}\' +'
alias json='python3 -m json.tool | bat --language json'
alias csv='pspg --csv -iX -s 17 --vertical-cursor --no-mouse'
alias nexusdb='psql -U dtone -h 127.0.0.1 -p 5433 fm'
alias sftporacle='sftp -i ~/.ssh/id_rsa_t2 digital-value-services@sftp.oracle.transferto.com'
alias jupyter='~/anaconda3/bin/jupyter notebook --ip=0.0.0.0 --no-browser'
alias mailcatcher='docker-compose -f /opt/dev/mailcatcher/docker-compose.yml'
alias start_billing='(cd /current/billing && DBIC_TRACE=4 PLACK_ENV=development carton exec -- start_server --port 5000 -- plackup -R ./lib -s Gazelle --max-reqs-per-child 1000 bin/app.pl)'
alias start_nxapi='(cd /current/nexus/admin-api && DBIC_TRACE=4 carton exec morbo script/admin -l http://0.0.0.0:9080 )'
alias start_nxgui='(cd /current/nexus/admin-interface && npm run dev )'
# allow local directory have its own bash aliases
if [[ -f .bash_aliases ]] && [[ "$PWD" != */home/murzilla* ]]; then
	. ./.bash_aliases
fi
