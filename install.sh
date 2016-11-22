#!/bin/bash

echo "Download Vundle..."
if [[ -d ~/.vim/bundle/Vundle.vim ]]; then
    rm -rf ~/.vim/bundle/Vundle.vim
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

if [[ $? != 0  ]]; then
    echo "Download Vundle failed, please download it manually"
    exit 1
fi

echo "Make symbolic link ./_vimrc to ~/.vimrc"
ln -sf $(pwd)/_vimrc ~/.vimrc && vim +PluginInstall

