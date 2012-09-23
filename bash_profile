path=""
if [[ -e $HOME/.path ]]; then
  for entry in $(< $HOME/.path ); do
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
export CDPATH=.:~/p
export EDITOR=vim
export ENVPATH=/home/jrm/.env
export HISTIGNORE="&"
export HISTSIZE=1000
export HISTFILESIZE=2000
export LESS='-i -z-4 -g -M -X -F -R -Q'
export PAGER=less

if [[ -f $HOME/.bashrc ]]; then
  source $HOME/.bashrc
fi
