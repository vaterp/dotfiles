#rhub is my desktop so I might want to set that up differently
HST=`/bin/hostname`

#History options
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=~/.history
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY


#Bindkey setup

bindkey -v

bindkey "" history-incremental-search-backward

bindkey "^Xf" insert-files ##C-x-f

zle-history-line-set() {zle -K vicmd;}
zle -N zle-history-line-set

#Set Terminal Title
precmd () {print -Pn "\e]0;%n@%m: %~\a"}

#Bash Shell Setup
FIGNORE='~:.o:.d:.a:CVS'


export PATH=~/bin:$PATH:/sbin:/usr/X11R6/bin

#Unix Utils Setup
export PAGER=less
export LESS="-IRMnX"

#CVS Setup....
#export CVSROOT=unxcvs:/devel/netmodem/cvs/repos
export CVSROOT=cvs.eng.idirect.net:/repos/netmodem
export CVS_RSH=ssh

#Current Helpers....
ulimit -c unlimited




#Unix Shortcuts...


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

hostnames=(terp bsnyder01)
compctl -k hostnames ping telnet ncftp ftp host nslookup rlogin ssh scp
function cmprs { cd ~/work ; reply=(`ls -d *(/)`); }
compctl -K cmprs revset

function cleanup
{
 echo "Removing all doa~ and binary Files"
 find . -type f -name '*.d' | xargs -r rm
 find . -type f -name '*.o' | xargs -r rm
 find . -type f -name '*~' | xargs -r rm
 find . -type f -name '*.a' | xargs -r rm
 find . -type f -name 'na'  | xargs -r rm
 find . -type f -name 'sarouter' | xargs -r rm
 find . -type f -name 'sarmt' | xargs -r rm
 find . -type f -name 'sada' | xargs -r rm
 find . -type f -name 'falcon' | xargs -r rm
 find . -type f -name 'sana' | xargs -r rm
}

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


#
#Lantronix helpers
#

lt() 
{ 
	print -Pn "\e]0; $1 \a"
	telnet lant 100"$2"
}

#st () {print -Pn "\e]0; $1 \a"}
plt()
{
	print -Pn "\e]0; $1 \a"
	telnet plant 100"$2"
}



#
#end LANTRONIX helpers
#

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
