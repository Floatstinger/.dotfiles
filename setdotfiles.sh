#!/bin/sh

#Set up zsh rc symlink
ln -sf $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc

#Setup emacs and exwm config
mkdir -p $HOME/.emacs.d/
ln -sf $HOME/.dotfiles/emacs/init.el $HOME/.emacs.d/init.el

#Setup xinitrc
ln -sf $HOME/.dotfiles/xinit/.xinitrc $HOME/.xinitrc
