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
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] \w\[\033[00m\] \! >'
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

alias more='less'
alias l='less'
alias pp="pstree -ph"
alias psa="ps -fu bsnyder | grep -v '\(xterm\|screen\|SCREEN\|multi-gnome\|zsh\|ps -fu\|vi\)'"
alias ll='ls -hrtlI '
alias ls='ls -hFI '
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear



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


#TMUX stuff
alias tls='tmux list-session'

alias webshare='python -m SimpleHTTPServer 8080'

CDPATH=.:~:~/work

#ipfw helpers
alias ipl='ipfw pipe list | grep burst'
alias ifl='ipfw -a list'
alias ipw='while true; do ipl | grep 003; echo;echo; ifl | grep 00201; sleep 5; clear; done'

