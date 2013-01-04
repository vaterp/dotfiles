# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias ifc="ifconfig | grep inet | grep 172.20"

SHELL=bash
if [ -f ~/.alias ]; then
	. ~/.alias
fi

unset MAILCHECK
shopt -u mailwarn

PS1="\u@\h \w \# >"
# User specific aliases and functions
