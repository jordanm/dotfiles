for filename in "$HOME/.git-completion.sh" "$HOME/.git-prompt.sh" "$HOME/.bin/nvm"; do
  if [[ -e $filename ]]; then
    source $filename
  fi
done

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 
export PS1="\[\033]0;${PROMPTPREFIX}\w\007\]\[\033[0;33m\]${PROMPTPREFIX}\w\[\033[0;32m\]\$(__git_ps1 ' (%s)') \[\033[0m\]"
export PROMPT_COMMAND="history -a; history -n;"

if [[ -e $HOME/.dircolors ]]; then
  eval "$(dircolors $HOME/.dircolors)"
fi

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
shopt -s histappend
shopt -s nocaseglob
shopt -s no_empty_cmd_completion
shopt -u mailwarn
shopt -s sourcepath

alias ..='cd ..'
alias c='clear'
alias df='df -kTh'
alias ds='du -h --max-depth=1'
alias du='du -h'
alias g='git'
alias h='history'
alias i='ipython'
alias ls='ls -hFH --color'
alias lsd='find . -maxdepth 1 -type d'
alias mkdir='mkdir -pv'
alias pytree='tree --dirsfirst -P "*.py" -I "__init__.py"'
alias q='exit'
alias rmpyc='find . -name *.pyc -delete'
alias tree='tree -l'

gh() { 
  history | egrep -v '  history|  gh' | grep --color $1 | tail -1
}

gt() {
  if [[ $1 == -c ]]; then
    shift
    find . -type f -print | egrep -v "\.sw[p|o]|\.py[c|o]|\.png|\.gif|/\.git/|/\.svn/|/_doctrees/|/\.project/" | xargs grep -Hns --color $@
  else
    find . -type f -print | egrep -v "\.sw[p|o]|\.py[c|o]|\.png|\.gif|/\.git/|/\.svn/|/_doctrees/|/\.project/" | xargs grep -ls --color $@
  fi
}

alias gad='git ad'
alias gai='git ai'
alias gau='git au'
alias gbn='git bn'
alias gcm='git cm'
alias gco='git co'
alias gdc='git dc'
alias gdf='git df'
alias gft='git ft'
alias glg='git lg'
alias gll='git ll'
alias gph='git ph'
alias gpl='git pl'
alias gpu='git pu'
alias grp='git grep'
alias gst='git st'

ff() { find . -type f -iname '*'$*'*' -print; }
fd() { find . -type d -iname '*'$*'*' -print; }
fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;; }

p() { ps $@ -o pid,ppid,euser,tty,nice,stat,%cpu,%mem,vsz,rss,nlwp,args; }
pe() { p -e; }
pu() { p -u $USER; }

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
