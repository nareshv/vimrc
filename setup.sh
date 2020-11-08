#!/bin/bash

# Program to automatically setup the vim environment
# Author: vnareshkumar@gmail.com
# License: MIT

if [[ -f "$HOME/.vimrc" || -f "$HOME/.gvimrc" ]];then
	echo "Your vim installation is already configured. Exiting ..."
	exit 2
fi

VIMRC=$HOME/.vimrc
VIMDIR=$HOME/.vim/
AUTOLOAD=$VIMDIR/autoload
BUNDLEDIR=$VIMDIR/bundle

mkdir -p $AUTOLOAD $BUNDLEDIR && curl -LSso $AUTOLOAD/pathogen.vim https://tpo.pe/pathogen.vim

cat <<'EOF' > $VIMRC
set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on
set ts=4 " Tab stop at 4 chars
set sw=4 " Soft width
set et " Expand tabs
set ai " Auto indent
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set colorcolumn=80 " highlight the line at 80th char
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
if has("gui_running")
  colo bluechia
  set guifont=AurulentSansMono\ Nerd\ Font\ 10
  au GUIEnter * set fullscreen
  source $VIMRUNTIME/mswin.vim
endif
EOF

echo "Created $VIMRC"

function install_package {
    P=$(basename $1)
	cd $BUNDLEDIR && test -d $P || git clone $1
}

# basic vim
install_package "https://github.com/tpope/vim-sensible.git"
# rainbow paranthesis
install_package "https://github.com/luochen1990/rainbow"
# syntax checks
install_package "https://github.com/vim-syntastic/syntastic"
# beautify code
install_package "https://github.com/godlygeek/tabular"
# Better scm integration
install_package "https://github.com/mhinz/vim-signify"
# Nice vim statusbar
install_package "https://github.com/vim-airline/vim-airline"
# tons of color schemes
install_package "https://github.com/flazz/vim-colorschemes"
# High speed html editing
install_package "https://github.com/mattn/emmet-vim"
# vim indent guides
install_package "https://github.com/nathanaelkane/vim-indent-guides"
# fix unwanted trailing whitepsace
install_package "https://github.com/bronson/vim-trailing-whitespace"
# install vue support
install_package "https://github.com/posva/vim-vue"
