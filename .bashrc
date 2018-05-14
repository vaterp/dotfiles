#I DONT USE THIS ANYMORE, NOW I USE .BASH_ALIASES FOR BETTER OOB INTEGRATION

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

DISTRO=unknown

if [ -f /etc/debian_version ]; then
	DISTRO=deb
elif [ -f /etc/redhat-release ]; then
	DISTRO=red
fi

# History Settings
export HISTCONTROL="ignoreboth"   #Don't put duplicate lines or lines starting with space in history
export HISTIGNORE="exit:history"
shopt -s histappend  #append to history file, don't overwrite it
shopt -s histverify #Allow for verification with a substituted history expansion
HISTSIZE=1000
HISTFILESIZE=1000
PROMPT_COMMAND='history -a;'

shopt -s autocd

#Shared environment setting controls
#export PATH=~/bin:$PATH:/sbin:/usr/X11R6/bin
export CDPATH=~
FIGNORE='~:.o:.d:.a:CVS'



#Completion controls
#set completion-ignore-case on
#set completion-prefix-display-length 4

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize  #This is always in /etc/bash.bashrc

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

EDITOR=vi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

cd

unset MAILCHECK
shopt -u mailwarn
