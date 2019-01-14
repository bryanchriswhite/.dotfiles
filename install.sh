#!/bin/bash

# Variables
ps1_prefix=$1
dir=$(dirname $(realpath $0))
bashrc="${HOME}/.bashrc"
files=".gitconfig
.vimrc
.tmux.conf"
to_source=".bash_aliases
.bash_functions
.bash_ps1"
to_link=("${files[@]}" "${to_source[@]}")

ensure_line() {
  if ! grep -qP $1 ${bashrc}; then
    echo "no line $1"
    cat >> ${bashrc}
  else
    echo "yes line $1"
  fi
}

for f in $to_source; do
  ensure_line '(?<!#)(source|\.)\s+.*'${f} << EOF
if [ -f ~/${f} ]; then
  . ~/${f}
fi
EOF
done

cd ${dir} && git submodule update --init

# Vim plugins
vim_autoload=${HOME}/.vim/autoload
vim_bundle=${HOME}/.vim/bundle
vim_pathogen=${vim_autoload}/pathogen.vim
vim_nerdtree=${vim_bundle}/nerdtree
if [[ ! -d ${vim_autoload} ]]; then
  mkdir -p ${vim_autoload}
fi

if [[ ! -d ${vim_bundle} ]]; then
  mkdir -p ${vim_bundle}
fi

if [[ ! -e ${vim_pathogen} ]]; then
  echo "Creating vim pathogen symlink";
  ln -s "${dir}/vim/vim-pathogen/autoload/pathogen.vim" ${vim_pathogen};
fi

if [[ ! -e ${vim_nerdtree} ]]; then
  echo "Creating vim nerdtree symlink";
  ln -s "${dir}/vim/nerdtree" ${vim_nerdtree};
fi

# Symlink dotfiles
for f in ${to_link[@]}; do
  user=$(whoami)
  user_target=${dir}/${f}.${user}
  if [[ -e ${user_target} ]]; then
    target_path="${user_target}";
  else
    target_path="${dir}/${f}";
  fi
  link_path="${HOME}/${f}";

  if [[ -f ${link_path} ]]; then
    echo "File ${link_path} exists and is not a symlink; NOT OVERWRITING!";
  else
    echo "creating symlink from ${target_path} to ${link_path}"
    ln -s ${target_path} ${link_path};
  fi

done
