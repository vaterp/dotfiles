#
#Things that are probably already in .bashrc by default
#
export HISTCONTROL="ignoreboth:erasedups"   #Don't put duplicate lines or lines starting with space in history
#shopt -s histappend  #append to history file, don't overwrite it
#HISTSIZE=1000
#HISTFILESIZE=1000
#shopt -u mailwarn

#these were in my own .bashrc but not sysdefaults
export HISTIGNORE="exit:history"
shopt -s histverify #Allow for verification with a substituted history expansion
PROMPT_COMMAND='history -a;'

if [[ "$OSTYPE" != "darwin23" ]]; then #This doesnt work on MAC bash default version
  shopt -s autocd
  export CDPATH=.:~:~/work
  FIGNORE='~:.o:.d:.a:'
  shopt -s globstar #Pattern "**" matches pathnaem expansion
else #I'm a MAC!
  PS1='\u@:\w $'
  alias dtf='cd ~/dotfiles'
  alias te='open -a TextEdit'
fi

#unameOut="$(uname -s)"
#case "${unameOut}" in
#    Linux*)     machine=Linux;;
#    Darwin*)    machine=Mac;;
#    CYGWIN*)    machine=Cygwin;;
#    MINGW*)     machine=MinGw;;
#    MSYS_NT*)   machine=Git;;
#    *)          machine="UNKNOWN:${unameOut}"
#esac
#echo ${machine}

unset MAILCHECK
EDITOR=vi

#
#Aliases
#
alias tls='tmux list-session'
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
alias lf="find . -type f -print0 | xargs -0 grep -n"

function highlight {
  grep -E "^|.*$1.*"
}

alias l='less'
alias pp="pstree -ph"

#LS aliases
alias lla='ls -hartl --color=tty'
alias ll='ls -hrtl --color=tty'
alias ls='ls -hF --color=tty'
alias cl="clear; ll"
alias cla="clear; lla"

alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear

#
#Git helpers
#
alias cls='clear;git ls'
alias gsh='git status -sb ; git hist -3'
alias gshu='git status -sbuno ; git hist -3'
function showGits {
  find . -name '.git' -type d
}
function checkGits {
  find . -name '.git' -type d | while read line; do
     echo "Checking: $line"
     pushd `dirname $line` > /dev/null
     if [ $# -eq 1 ]; then
       git fetch
     fi
     gsh
     echo "========================================================================"
     popd > /dev/null
   done
}

#
#Admin Helpers
#
function sip() { #See IpAddress on interfaces
 ip -o -4 addr  | awk '{print $2 "  "  $4}' | grep -v 127.0.0.1
}

alias webshare='python -m SimpleHTTPServer 8080'
alias p='python3'

function repeat() {
  for ((n=0;n<$1;n++))
  do 
    eval ${*:2}
    done
  }

#
#Root Sudo aliases:
#
alias tcpdump='sudo /usr/sbin/tcpdump -ln'
alias tftpd='sudo   /sbin/in.tftpd --foreground -vvvv -p -c -s /tmp/tftpboot'

function toptar ()
{  # Only show top level directories in a tar file
   tar --exclude='*/*' -tf $1
}

#ipfw helpers
alias ipl='ipfw pipe list | grep burst'
alias ifl='ipfw -a list'
alias ipw='while true; do clear; ipl | grep 003; echo;echo; ifl | grep 00200; sleep 5;  done'
