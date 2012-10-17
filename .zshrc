#rhub is my desktop so I might want to set that up differently
HST=`/bin/hostname`

#Set Terminal Title
precmd () {print -Pn "\e]0;%n@%m: %~\a"}
#
#Bash Shell Setup
FIGNORE='~:.o:.d:.a:CVS'
function revset
{
	export REV=$1

	export xid=~bsnyder/work/$REV/phoenix/iDirect
	export xh=$xid/hpb
	export xp=$xh/lib/protocol

	export eid=~bsnyder/work/$REV/eserver/iDirect
	export eh=$eid/hpb
	export ep=$eh/lib/protocol

  if [[ -n $2 ]]
	then
		export TARGET_ID=phoenix
		export id=$xid
		export h=$xh
		export p=$xp
		#export lwip=$xid/third_party/lwip/contrib/ports/unix/proj/minimal
		#export dcl=$xid/third_party/dcl/dc_root
	else
		unset TARGET_ID
		export id=$eid
		export h=$eh
		export p=$ep
		#export lwip=$eid/third_party/lwip/contrib/ports/unix/proj/minimal
		#export dcl=$eid/third_party/dcl/dc_root
		export pkg=$eh/script/pkg_scripts
	fi

	#export dg=$dcl/jobs/gnu
	#CDPATH=.:~:$h:$p:$id:$id/shared/stack:$dcl
	CDPATH=.:~:$h:$p:$id:$id/shared/stack
	if [[ -d $id ]]; then
		cd $id
	fi
}


revset 3.1.0.99

export PATH=~/bin:$PATH:/sbin:/usr/X11R6/bin

#Unix Utils Setup
export PAGER=less
export LESS="-IMnX"

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
bindkey "^Xf" insert-files ##C-x-f


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

#This is just an example of a function with a param...
function v {vim -O $1.cpp $1.h* }
#function chpwd { print -Pn "\033]2;%m:%~\007" }
function  psn  {ps -fu root | grep -w na |  grep -v grep}

#Screen handies....
function sv {screen -t $1 vi $1}



bindkey -v



#
#Lantronix helpers
#

lt() 
{ 
	print -Pn "\e]0; $1 \a"
	telnet lant 100"$2"
}

#st () {print -Pn "\e]0; $1 \a"}



#
#end LANTRONIX helpers
#

function av
{
	ack -H --nocolor --nogroup $1 | vi -
}

source ~/.alias

cd
