#rhub is my desktop so I might want to set that up differently
HST=`/bin/hostname`

#History options
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=~/.zshhistory
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt interactivecomments #Put a '#' at fron of cmd to push comment into history


export EDITOR=vim

#Bindkey setup
#bindkey -v
#zle-history-line-set() {zle -K vicmd;}
#zle -N zle-history-line-set

bindkey -e

#Make some things more bash like to keep my brain centered.
bindkey "" history-incremental-search-backward
bindkey "^Xf" insert-files ##C-x-f
bindkey -M emacs '\e#' pound-insert
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line


#Set Terminal Title
precmd () {print -Pn "\e]0;%n@%m: %~\a"}

#Unix Utils Setup
export PAGER=less
export LESS="-IRMnX"

#Current Helpers....
#ulimit -c unlimited



#ZSH Specific Stuff...

if [ `whoami` = "root" ]; then
PROMPT='%Broot@%m %~ %h #%b'
else
PROMPT='%B%m %~ %h >%b'
fi
autoload -U compinit
compinit

autoload -U insert-files
zle -N insert-files


#setopt correct
#setopt auto_name_dirs
setopt rm_star_silent
setopt EXTENDED_GLOB 
setopt cdable_vars 
setopt autocd 
setopt autopushd 
setopt pushdignoredups

function hiline
{
	 egrep --color ".* $1 .*|$"
 }
function hiword
{
	 egrep --color "$1|$"
}

function stopat 
{
				sed -n "1,/$1/ p" | hiword $1
}
function startat
{
				sed -n "/$1/,$ p" | hiword $1
}

#This is just an example of a function with a param...
function v {vim -O $1.cpp $1.h }
#function chpwd { print -Pn "\033]2;%m:%~\007" }
function  psn  {ps -fu root | grep -w na |  grep -v grep}

#Screen handies....
function sv {screen -t $1 vi $1}

if [ `hostname` != "researchPP1" ]; then
	
	#Git PROMPT Enhancements
	setopt prompt_subst
	autoload -Uz vcs_info
	zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
	zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
	zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
	zstyle ':vcs_info:*' enable git cvs svn

	# or use pre_cmd, see man zshcontrib
	vcs_info_wrapper() {
		vcs_info
		if [ -n "$vcs_info_msg_0_" ]; then
			echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
		fi
	}
	RPROMPT=$'$(vcs_info_wrapper)'

fi

function av
{
	ack -H --nocolor --nogroup $1 | vi -
}

function 2d
{
	printf "%d\n" 0x$1
}
function 2h
{
	printf "%x\n" $1
}

source ~/.alias

cd
