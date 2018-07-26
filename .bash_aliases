#
#Things that are probably already in .bashrc by default
#
#export HISTCONTROL="ignoreboth"   #Don't put duplicate lines or lines starting with space in history
#shopt -s histappend  #append to history file, don't overwrite it
#HISTSIZE=1000
#HISTFILESIZE=1000
#shopt -u mailwarn

#these were in my own .bashrc but not sysdefaults
export HISTIGNORE="exit:history"
shopt -s histverify #Allow for verification with a substituted history expansion
PROMPT_COMMAND='history -a;'

shopt -s autocd
export CDPATH=~:work
FIGNORE='~:.o:.d:.a:CVS'

shopt -s globstar #Pattern "**" matches pathnaem expansion
unset MAILCHECK
EDITOR=vi




#
#Aliases
#
alias hu='history -n'  #Merge history from other shells
alias iptv='sudo iptables -vnL INPUT'
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

function showGits {
  find . -name '.git' -type d
}

function highlight {
  grep -E "^|.*$1.*"
}

alias more='less'
alias l='less'
alias pp="pstree -ph"
alias ll='ls -hrtl --color=tty'
alias ls='ls -hF --color=tty'
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear

#
#Git helpers
#
alias gst='git status -uno'

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

#
#Root Sudo aliases:
#
alias tcpdump='sudo /usr/sbin/tcpdump -ln'
alias tftpd='sudo   /sbin/in.tftpd --foreground -vvvv -p -c -s /tmp/tftpboot'


#
#Only show the top level directories in a tar file
#
toptar ()
{
#  tar -tf $1 | grep -o '^[^/]\+' | uniq
   tar --exclude='*/*' -tf $1
}

#ipfw helpers
alias ipl='ipfw pipe list | grep burst'
alias ifl='ipfw -a list'
alias ipw='while true; do clear; ipl | grep 003; echo;echo; ifl | grep 00200; sleep 5;  done'
