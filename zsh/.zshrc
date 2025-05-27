# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/(whoami)/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export PS1="[%n]-[%T] => [%d] %% "

#Aliases
alias ls='ls -lrta'
