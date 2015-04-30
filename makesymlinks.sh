#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory

##########

ln -Fs $dir/bashrc ~/.bashrc
ln -Fs $dir/bash_profile ~/.bash_profile
ln -Fs $dir/gitconfig ~/.gitconfig
ln -Fs $dir/gitignore ~/.gitignore
ln -Fs $dir/vimrc ~/.vimrc
ln -Fs $dir/tmux.conf ~/.tmux.conf
