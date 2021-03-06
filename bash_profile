path=""
if [[ -e $HOME/.path ]]; then
  for entry in $(< $HOME/.path); do
    if [[ -n "$path" ]]; then
      path="$path:$entry"
    else
      path=$entry
    fi
  done
fi
if [[ -n "$path" ]]; then
  path="$path:$PATH"
else
  path=$PATH
fi

export PATH="$path"
export BASEPATH="$path"

export BAKE_MODULES="spire.tasks mesh.tasks lattice.tasks"
export BASELINEPATH=$HOME/.baseline
export CDPATH=.:~/p
export EDITOR=vim
export ENVPATH=$HOME/.env
export HISTIGNORE="&:ls:la:ll:cd:exit:history:clear"
export HISTSIZE=999999
export HISTFILESIZE=999999
export LESS='-i -z-4 -g -M -X -F -R -Q'
export LILYTERM="/usr/bin/lilyterm -sl"
export NVM_DIR=$HOME/.nvm
export PAGER=less
export PGHOST=localhost
export PGPORT=5432
export PROJECTPATH=$HOME/p

if [[ -f $HOME/.bashrc ]]; then
  source $HOME/.bashrc
fi

if [[ -z "$DISPLAY" ]] && [[ -n "$XDG_VTNR" ]] && [[ "$XDG_VTNR" -eq 1 ]]; then
  exec startx
fi
