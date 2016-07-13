
DISTRO=unknown
if [ -f /etc/debian_version ]; then
	DISTRO=deb
elif [ -f /etc/redhat-release ]; then
	DISTRO=red
fi

# History Settings
export HISTIGNORE="exit:history"
shopt -s histverify #Allow for verification with a substituted history expansion
HISTSIZE=1000
HISTFILESIZE=1000
PROMPT_COMMAND='history -a;'

shopt -s autocd

#Completion controls
#set completion-ignore-case on
#set completion-prefix-display-length 4

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


#This is ugly... set this is .bashrc also
if [ `whoami` = "root" ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\] $(__git_ps1 "(%s)") \! >'
else
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\] $(__git_ps1 "(%s)") \! >'
fi

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


EDITOR=vi

unset MAILCHECK
shopt -u mailwarn



#Shared environment setting controls
export PATH=~/bin:$PATH:/sbin:/usr/X11R6/bin
FIGNORE='~:.o:.d:.a:CVS'


#Get GITHub
alias 'getgithub'='git clone https://github.com/vaterp/dotfiles.git'

#
#Aliases
#
alias hu='history -n'  #Merge history from other shells
#alias rs=revset
alias Ack=ack
alias ccm='cvs commit -m "CR 28247: '
alias gsr='gdb /usr/sbin/idirect/sarouter'
alias iptv='sudo iptables -vnL INPUT'
alias psh='pstree -ap `pgrep samnc`'
alias syshup='sudo kill -HUP `cat /var/run/syslogd.pid`'
alias gsr='gdb /usr/sbin/idirect/sarouter'
alias pt="pstree -ap `pgrep samnc`"
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

#changing these to 'l' instead of 'f' because fc is builtin.
alias lh="find . -regextype posix-egrep -regex '.*\.[h](pp)?' -type f -print0 | xargs -0 grep -n"
alias lc="find .  -regextype posix-egrep -regex '.*\.[c](pp)?' -type f -print0 | xargs -0 grep -n"
alias lhc="find . -regextype posix-egrep -regex '.*\.[ch](pp)?' -type f -print0 | xargs -0 grep -n"
#alias lhc="find . -type f -print0  \( -name '*.h*' -o -name '*.c*' \) | xargs -0 grep"
alias lf="find . -type f -print0 | xargs -0 grep -n"

function lg { 
grep -Ir --exclude="*~" "$1" *
#grep -Ir --exclude="*~" --exclude-dir=.git --exclude-dir=CVS "$1" *
}

function ruleEdit {
	if [[ -z $1 ]]
		then
		echo "Arg1 = id to add ; Arg2 set to l2os32 group"
	return
	fi

	GROUP="l2os"
	if [[ -n $2 ]]
	then
	GROUP="l2os32"
	fi
	#echo "ruleEdit -a $1 -g $GROUP"
	ssh cvs "ruleEdit -a $1 -g $GROUP"
}


alias more='less'
alias l='less'
alias pp="pstree -ph"
alias psa="ps -fu bsnyder | grep -v '\(xterm\|screen\|SCREEN\|multi-gnome\|zsh\|ps -fu\|vi\)'"
alias ll='ls -hrtl --color=tty'
alias ls='ls -hF --color=tty'
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear

alias s=screen
alias stc='screen -t console telnet 127.0.0.1 13255'
alias stm='screen -t messages sudo tail -f /var/log/messages'
alias tm='sudo tail -f /var/log/messages | hiline '
alias cdv='cd `cdv_perl`'
alias cdt='cd `cdt_perl`'
alias plx='pgrep -l -x'
alias pk='pkill -x na'
alias d='dirs -v'
alias lsd='ls -ld *(/)'
alias lse='find . -type f -perm +100'
alias script='script -f'
alias lsh='find . -type f -perm +100  | grep -v test | grep -v tools | grep -v dvbs2 | grep -v script | grep -v drivers | grep -v cougar | grep -v falcon | grep -v puma | grep -v ".sh$" '
alias alt="clear;alias | grep -v grep | grep -w lt | sort -nk3 | grep lt"
alias palt="alt | grep plt"


alias m516='lt m516 01' #m1='lt m516 01'
alias nexus='lt nexus 02' #m2='telnet lant 10002'
alias m658='lt m658 03' #m3='telnet lant 10003'
alias m514='lt m514 04' #m4='telnet lant 10004'
alias m703='lt m703 05' #m5='telnet lant 10005'
alias m4415='lt x7.4415 20' #X7
alias l27062='lt l27062 07' #l1='telnet lant 10007'
alias l26979='lt l26979 08' #l2='telnet lant 10008'
alias l17677='lt l17677 09' #l3='telnet lant 10009'
alias l27114='lt l27114 10' #l4='telnet lant 10010'
alias tunsw='lt tunsw 11'   tus='lt ts 11'
alias upssw='lt upssw 12'   us='lt us 12'
alias remsw='lt remsw 13' rs='lt rs 13'
alias psdn='lt psdn 14' 
alias asr5k24='lt asr5k24 24'
alias asr1k='lt uprtr 28'   ur1='lt r1 28'
alias dleper='lt DLEPer 29'
alias mrmag1='lt mrmag1 29' mm1='lt mm1 29'
alias mrmag2='lt mrmag2 31' mm2='lt mm2 31'
alias 2911='lt 2911 30'

alias tlc='plt transmit_line_card 12'
alias rlc='plt receive_line_card 14'
alias mdm='plt m267 10'

#Football Devices
alias falt="alt | grep FB-"
alias sw='lt FB-Switch 14'
alias m1x='lt FB-M-1-X7 26'
alias m1s='lt FB-M-1-SBC 05'
alias m2x='lt FB-M-2-X7 09'
alias m2s='lt FB-M-2-SBC 10'
alias l1='lt FB-LineCard-1 24'
alias l2='lt FB-LineCard-2 25'

#
#Git helpers
#
alias gst='git status -uno'

#until() {
  #sed -n "1,/$1/ p"
#}
#
#after() {
  #sed -n "/$1/,$ p"
#}
#
#inbetween() {
  #sed -n "/$1/,/$2/ p"
#}
#
#ghu() {
	#git hist $1~..HEAD
#}

#
#zsh aliases only:
#

#TMUX stuff
alias tls='tmux list-session'

#
#Admin Helpers
#
sip() { #See IpAddress on interfaces
 ip -o -4 addr  | awk '{print $2 "  "  $4}' | grep -v 127.0.0.1
}
alias webshare='python -m SimpleHTTPServer 8080'
alias p='python3'

#The alias doesnt have proper quoting...
#alias sip2='print -lr ip -o -4 addr  | awk \'{print $2 "  "  $4}\' | grep -v 127.0.0.1'

#
#OldSchool iDirect stuff...
#
lid() { #Show iDirectOldSchool bin builds
 find . -type f -name sada  -ls | cut -d' ' -f3,11-
 find . -type f -name sana  -ls | cut -d' ' -f3,11-
 find . -type f -name sarouter  -ls | cut -d' ' -f3,11-
 find . -type f -name sarmt  -ls | cut -d' ' -f3,11-
}


#
#Root Sudo aliases:
#
alias tcpdump='sudo /usr/sbin/tcpdump -lnieth0'
alias tftpd='sudo   /sbin/in.tftpd --foreground -vvvv -p -c -s /tmp/tftpboot'



CDPATH=.:~:~/work:~/work/idsapps

v=~/work/idsapps/vagrant/mips
t=~/work/idsapps/realtime/Projects/CatnissGeneric/Tunneler

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

#
#Lantronix helpers
#
lt() 
{ 
#	print -Pn "\e]0; $1 \a"  #This is for ZSH TITLE
	echo -ne "\033]0; $1 \007"
	telnet lant 100"$2"
}

#st () {print -Pn "\e]0; $1 \a"}
plt()
{
#	print -Pn "\e]0; $1 \a"  #This is for ZSH TITLE
	echo -ne "\033]0; $1 \007"
	telnet plant 100"$2"
}
#
#end LANTRONIX helpers
#


#
#Only show the top level directories in a tar file
#
toptar ()
{
#  tar -tf $1 | grep -o '^[^/]\+' | uniq
   tar --exclude='*/*' -tf $1
}

#
#Some Pioneer environments
#

#export na=~/pioneer/PP_NA
#export tpa=~/pioneer/PP_TPA
#export da=~/pioneer/PP_DA
#export lib=~/pioneer/PCS_Lib
#export dfoe=~/pioneer/OTA_Libs/protocol/dfoe
#export tu=~/pioneer/Test_Utils
#export p=~/pioneer
#alias jd="~/pioneer/Test_Utils/optgen/jsondiff.sh"
#alias jf="~/pioneer/Test_Utils/optgen/jsonfmt.sh"
#alias pbuild='make cleanall ; make localincs ; make ; make fatlib; make locallibs'
#CDPATH=$CDPATH:~/pioneer:~/pioneer/PCS_Lib
