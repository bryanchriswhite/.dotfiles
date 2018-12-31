#!/bin/bash

dir=$(dirname $0)
files=".gitconfig
.vimrc
.tmux.conf
.bashrc
.bash_aliases
.bash_functions"

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
