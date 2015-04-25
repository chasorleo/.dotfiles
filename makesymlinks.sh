#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory

##########

ln -s $dir/vimrc ~/.vimrc
ln -s $dir/gitconfig ~/.gitconfig
