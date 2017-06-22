for filename in "$HOME/.git-completion.sh" "$HOME/.git-prompt.sh" "$HOME/.bin/nvm"; do
  if [[ -e $filename ]]; then
    source $filename
  fi
done

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 
export PS1="\[\033]0;${PROMPTPREFIX}\w\007\]\[\033[0;34m\]${PROMPTPREFIX}\w\[\033[0;32m\]\$(__git_ps1 ' (%s)') \[\033[0m\]"
#export PROMPT_COMMAND="history -a; history -n;"

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
shopt -u mailwarn
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

alias ..='cd ..'
alias c='clear'
alias df='df -kTh'
alias dkt='sudo docker'
alias ds='du -h --max-depth=1'
alias du='du -h'
alias g='git'
alias h='history'
alias i='ipython'
alias ls='ls -hFH --color'
alias lsd='find . -maxdepth 1 -type d'
alias lspacnew='locate -e --regex "\.pac(new|orig|save)$"'
alias map='xargs -n1'
alias mkdir='mkdir -pv'
alias ping='ping -c 5'
alias pytree='tree --dirsfirst -P "*.py" -I "__init__.py" -I "__pycache__"'
alias q='exit'
alias rmpyc='find . -name "*.pyc" -delete'
alias tree='tree -l'

cpt() {
  fluxbox-remote "clientpatterntest $1" && fluxbox-remote result
}

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
vf() { find . -type f -iname '*'$1'*' -exec gvim -O {} +; }

fs() {
  if [[ -n "$@" ]]; then
    du -sbh -- "$@"
  else
    du -sbh .[^.]* *
  fi
}

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

hash git &>/dev/null
if [[ $? -eq 0 ]]; then
  diff() {
    git diff --no-index --color-words "$@"
  }
fi

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

__local_git_complete() {
  local wrapper="__local_git_wrap${2}"
  eval "$wrapper () { __git_func_wrap $2; }"
  complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
    || complete -o default -o nospace -F $wrapper $1
}

__local_git_complete gad _git_add
__local_git_complete gau _git_add
__local_git_complete gbn _git_branch
__local_git_complete gcm _git_commit
__local_git_complete gco _git_checkout
__local_git_complete gdc _git_diff
__local_git_complete gdf _git_diff
__local_git_complete gft _git_fetch
__local_git_complete glg _git_log
__local_git_complete gll _git_log
__local_git_complete gph _git_push
__local_git_complete gpl _git_pull
__local_git_complete gpu _git_push
__local_git_complete grp _git_grep

source $HOME/.rvm/scripts/rvm
