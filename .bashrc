#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
PS1='[\u@\h \W]\$ '
