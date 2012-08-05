source ~/.git-completion.sh

parse_git_branch() {
    local ref=$(git symbolic-ref HEAD 2>/dev/null)
    if [ -n "$ref" ]; then
        local w=""
        git diff --no-ext-diff --quiet --exit-code || w="+"
        git diff-index --cached --quiet HEAD -- || w="+"
        echo " ("${ref#refs/heads/}$w")"
    fi
}

export PS1="\[\033]0;${PROMPTPREFIX}\u@\h:\w\007\]\[\033[0;33m\]${PROMPTPREFIX}\u$($HOME/.prompt-hostname):\w\[\033[0;32m\]\$(parse_git_branch) \[\033[0m\]"
eval "$(dircolors /home/jrm/.dircolors)"

umask 002
ulimit -S -c 0

set -o ignoreeof
set -o monitor
set -o notify
set -o vi
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s extglob
shopt -s nocaseglob
shopt -s no_empty_cmd_completion
shopt -u mailwarn
shopt -s sourcepath

alias pq='psql -U postgres'
alias ..='cd ..'
alias brc='source ~/.bashrc'
alias c='clear'
alias df='df -kTh'
alias ds='du -h --max-depth=1'
alias du='du -h'
alias g='egrep --color'
alias gt='find . -type f -print | grep -v ".swp" | grep -v ".pyc" | xargs grep -ls $@'
alias h='history'
alias i='ipython'
alias j='jobs -l'
alias l='less'
alias ls='ls -hFH --color'
alias lsd='find . -maxdepth 1 -type d'
alias lt='tree -Csu'
alias lterm='lilyterm'
alias mkdir='mkdir -pv'
alias nautilus='nautilus --no-desktop'
alias rscp='rsync -a --progress --inplace --whole-file'
alias q='exit'
alias tree='tree -l'
alias pytree='tree --dirsfirst -P "*.py" -I "__init__.py"'
alias rhino='java -cp /usr/share/java/js.jar org.mozilla.javascript.tools.shell.Main -opt -1'

alias gad='git add'
alias gau='git add -u'
alias gbn='git branch'
alias gco='git checkout'
alias gdf='git diff --color'
alias gdft='git difftool'
alias gft='git fetch'
alias glg='git log'
alias gcm='git commit -m'
alias gpl='git pull'
alias gpu='git push'
alias gri='git rebase -i'
alias grp='git grep'
alias gst='git status'
alias gmv='git mv'
alias gmt='git checkout -b mt'

alias svs='svn st'
alias svu='svn up'
alias svc='svn commit -m'
alias svl='svn log -l 10'
alias sva='svn add'

alias cdp='cd /home/jrm/p/'

ex() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z ) uncompress $1 ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi  
}

ff() { find . -type f -iname '*'$*'*' -print; }
ffr() { find / -type f -iname '*'$*'*' -ls; }
fd() { find . -type d -iname '*'$*'*' -ls; }
fdr() { find / -type d -iname '*'$*'*' -ls; }
fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;; }
fer() { find / -type f -iname '*'$1'*' -exec "${2:-file}" {} \;; }

p() { ps $@ -o pid,ppid,euser,tty,nice,stat,%cpu,%mem,vsz,rss,nlwp,args; }
pe() { p -e; }
pu() { p -u $USER; }

gh() { history | egrep -v '  history|  gh' | grep --color $1 | tail -1; }
mktar() { tar cjf "${1%%/}.tar.bz2" "${1%%/}/"; }
vsed() { vim -u NONE -i NONE -Nnes "+se ul=-1" $1 "+update|q" $2; }

unalias la 2>/dev/null
la() {
    ls -lahF "$@" | egrep "^d"
    ls -lahFb "$@" 2>/dev/null | egrep -v "^d|total "
}

unalias ll 2>/dev/null
ll() {
    ls -lhF "$@" | egrep "^d"
    ls -lhFb "$@" 2>/dev/null | egrep -v "^d|total "
}

gls() {
    jump="no"
    if [ "$1" = "-j" ]; then
        jump="yes"
    fi
    for dir in $(ls -1 --color=no /home/jrm/p); do
        pr="/home/jrm/p/$dir"
        if [ -d "$pr/.git" ]; then
            (
            cd $pr
            modified=$(git status -uno -s | wc -l)
            if [ "$modified" -ne "0" ]; then
                if [ "$jump" = "yes" ]; then
                    exit 17
                fi
                echo $dir
            fi
            )
            if [ $? -eq "17" ]; then
                cd $pr
                break
            fi
        fi
    done
}


complete -A hostname rsh rcp telnet rlogin r ftp ping disk
complete -A export printenv
complete -A variable export local readonly unset
complete -A enabled builtin
complete -A alias alias unalias
complete -A function function
complete -A user su mail
complete -A directory mkdir rmdir
complete -A job -P '%' fg jobs disown
complete -A directory -o default cd

complete -o bashdefault -o default -o nospace -F _git_add gad
complete -o bashdefault -o default -o nospace -F _git_add gau
complete -o bashdefault -o default -o nospace -F _git_branch gbn
complete -o bashdefault -o default -o nospace -F _git_commit gcm
complete -o bashdefault -o default -o nospace -F _git_checkout gco
complete -o bashdefault -o default -o nospace -F _git_diff gdf
complete -o bashdefault -o default -o nospace -F _git_diff gdft
complete -o bashdefault -o default -o nospace -F _git_fetch gft
complete -o bashdefault -o default -o nospace -F _git_grep grp
complete -o bashdefault -o default -o nospace -F _git_log glg
complete -o bashdefault -o default -o nospace -F _git_pull gpl
complete -o bashdefault -o default -o nospace -F _git_push gpu
