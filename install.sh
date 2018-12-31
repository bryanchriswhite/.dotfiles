#!/bin/bash

dir=$(dirname $0)
files=".gitconfig
.vimrc
.tmux.conf
.bashrc
.bash_aliases
.bash_functions"

git submodules update --init

# Vim plugins
vim_autoload=$HOME/.vim/autoload
vim_bundle=$HOME/.vim/bundle
vim_pathogen=$vim_autoload/pathogen.vim
vim_nerdtree=$vim_bundle/nerdtree
if [ ! -d $vim_autoload ]; then
  mkdir -p $vim_autoload
fi

if [ ! -d $vim_bundle ]; then
  mkdir -p $vim_bundle
fi

if [ ! -e $vim_pathogen ]; then
  echo "Creating vim pathogen symlink";
  ln -s "$dir/vim/vim-pathogen/autoload/pathogen.vim" $vim_pathogen;
fi

if [ ! -e $vim_nerdtree ]; then
  echo "Creating vim nerdtree symlink";
  ln -s "$dir/vim/nerdtree" $vim_nerdtree;
fi

# Dotfiles
for f in $files; do
  target_path=$(realpath "$dir/$f");
  link_path="$HOME/$f";

  if [ -f $link_path ]; then
    if [ -h $link_path ]; then
      rm -i $link_path;
    else
      echo "File $link_path exists and is not a symlink; NOT OVERWRITING!";
      exit 1;
    fi
  fi

  echo "creating symlink from $target_path to $link_path"
  ln -s $target_path $link_path;
done
