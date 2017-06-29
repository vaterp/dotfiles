


#Get GITHub
alias 'getgithub'='git clone https://github.com/vaterp/dotfiles.git'

#
#Aliases
#
alias hu='history -n'  #Merge history from other shells
#alias rs=revset
alias Ack=ack
#alias sc='cu -l /dev/ttyS0 -s 9600'
#alias ifconfig='/sbin/ifconfig'
#alias service='/sbin/service'
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

alias more='less'
alias l='less'
alias pp="pstree -ph"
alias psa="ps -fu bsnyder | grep -v '\(xterm\|screen\|SCREEN\|multi-gnome\|zsh\|ps -fu\|vi\)'"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias ll='ls -hrtl '
alias ls='ls -F '
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias plx='pgrep -l -x'
alias pk='pkill -x na'
alias d='dirs -v'
alias lsd='ls -ld *(/)'
alias lse='find . -type f -perm +100'
alias script='script -f'
alias lsh='find . -type f -perm +100  | grep -v test | grep -v tools | grep -v dvbs2 | grep -v script | grep -v drivers | grep -v cougar | grep -v falcon | grep -v puma | grep -v ".sh$" '
alias alt="clear;alias | grep -v grep | grep -w lt | sort -nk3 | grep lt"
alias palt="alt | grep plt"


#
#Git helpers
#
alias gst='git status -uno'


sip() { #See IpAddress on interfaces
 ip -o -4 addr  | awk '{print $2 "  "  $4}' | grep -v 127.0.0.1
}
alias webshare='python -m SimpleHTTPServer 8080'
alias p='python3'


#CDPATH=.:~:~/work:~/work/idsapps
