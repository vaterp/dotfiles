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
	cd $id
}

alias rs=revset

revset 3.1.0.99

alias Ack=ack
alias ccm='cvs commit -m "CR 28247: '
alias gsr='gdb /usr/sbin/idirect/sarouter'
export PATH=~/bin:$PATH:/sbin:/usr/X11R6/bin

#Unix Utils Setup
export PAGER=less
export LESS="-IMnX"

#CVS Setup....
#export CVSROOT=unxcvs:/devel/netmodem/cvs/repos
export CVSROOT=cvs.eng.idirect.net:/repos/netmodem
export CVS_RSH=ssh

#Current Helpers....
alias iptv='sudo iptables -vnL INPUT'
alias psh='pstree -ap `pgrep samnc`'
alias syshup='sudo kill -HUP `cat /var/run/syslogd.pid`'
alias gsr='gdb /usr/sbin/idirect/sarouter'
ulimit -c unlimited


alias pt="pstree -ap `pgrep samnc`"


#Unix Shortcuts...
alias sc='cu -l /dev/ttyS0 -s 9600'
alias ifconfig='/sbin/ifconfig'
alias service='/sbin/service'
alias d='diff'
alias diff='diff -w --side-by-side --suppress-common-lines'
alias g='grep'
alias gi='grep -i'
alias gl='grep -l'
alias od='od -t x'
alias vi='vim -O'
alias writeable='find . -type f -perm -u+w'
alias exe='find . -type f -perm -u+x'
alias fn='find . -name'
alias f='find . -type f -print0 | xargs -0 grep'
alias fw='find . -type f -print0 | xargs -0 grep -w '
alias fh="find . -regextype posix-egrep -regex '.*\.[h](pp)?' -type f -print0 | xargs -0 grep"
alias fc="find .  -regextype posix-egrep -regex '.*\.[c](pp)?' -type f -print0 | xargs -0 grep"
alias fhc="find . -regextype posix-egrep -regex '.*\.[ch](pp)?' -type f -print0 | xargs -0 grep"
#alias fhc="find . -type f -print0  \( -name '*.h*' -o -name '*.c*' \) | xargs -0 grep"
alias more='less'
alias l='less'
alias pp="pstree -p"
alias psa="ps -fu bsnyder | grep -v '\(xterm\|screen\|SCREEN\|multi-gnome\|zsh\|ps -fu\|vi\)'"
alias ll='ls -hrtl --color=tty'
alias ls='ls -hF --color=tty'
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear
alias pd=perldoc
alias clm="cvs log -w bsnyder"


#ZSH Specific Stuff...

#Root Sudo aliases:
alias tcpdump='sudo /usr/sbin/tcpdump -lnip4p1'
alias tftpd='sudo   /sbin/in.tftpd --foreground -vvvv -p -c -s /tmp/tftpboot'

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
alias s=screen

alias stc='screen -t console telnet 127.0.0.1 13255'
alias stm='screen -t messages sudo tail -f /var/log/messages'
alias tm='sudo tail -f /var/log/messages | hiline '

alias cdv='cd `cdv_perl`'
alias cdt='cd `cdt_perl`'
alias plx='pgrep -l -x'
alias pk='pkill -x na'
alias d='dirs -v'
alias -g L='| less'
alias -g G='|grep --color'
alias -g GI='|grep -i --color'
alias -g T='|tail'
alias -g H='|head'
alias -g N='&>/dev/null&'
alias lsd='ls -ld *(/)'
alias lse='find . -type f -perm +100'
alias lsh='find . -type f -perm +100  | grep -v test | grep -v tools | grep -v dvbs2 | grep -v script | grep -v drivers | grep -v cougar | grep -v falcon | grep -v puma | grep -v ".sh$" '

bindkey -v

alias -s cpp=vim
alias -s h=vim
alias -s txt=vim
alias -s log=vim


#
#Lantronix helpers
#

lt() 
{ 
	print -Pn "\e]0; $1 \a"
	telnet lant 100"$2"
}

#st () {print -Pn "\e]0; $1 \a"}

alias alt="clear;alias | grep -v grep | grep lt | sort -nk3 | grep lt"

alias m516='lt m516 01' #m1='lt m516 01'
alias m689='lt m689 02' #m2='telnet lant 10002'
alias m658='lt m658 03' #m3='telnet lant 10003'
alias m514='lt m514 04' #m4='telnet lant 10004'
alias m703='lt m703 05' #m5='telnet lant 10005'
alias l27062='lt l27062 07' #l1='telnet lant 10007'
alias l26979='lt l26979 08' #l2='telnet lant 10008'
alias l17677='lt l17677 09' #l3='telnet lant 10009'
alias l27114='lt l27114 10' #l4='telnet lant 10010'
alias tunsw='lt tunsw 11'   ts='lt ts 11'
alias upssw='lt upssw 12'   us='lt us 12'
alias remsw='lt remsw 13' rs='lt rs 13'
alias psdn='lt psdn 14' 
alias asr5k24='lt asr5k24 24'
alias asr1k='lt uprtr 28'   ur1='lt r1 28'
alias mrmag1='lt mrmag1 29' mm1='lt mm1 29'
alias mrmag2='lt mrmag2 31' mm2='lt mm2 31'
alias 2911='lt 2911 30'

#
#end LANTRONIX helpers
#

function av
{
	ack -H --nocolor --nogroup $1 | vi -
}
cd
