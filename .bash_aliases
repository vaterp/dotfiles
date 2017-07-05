#Get GITHub
alias 'getgithub'='git clone https://github.com/vaterp/dotfiles.git'

#
#Aliases
#
alias hu='history -n'  #Merge history from other shells

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
alias d='dirs -v'
alias lse='find . -type f -perm +100'
alias script='script -f'

alias webshare='python -m SimpleHTTPServer 8080'
alias p='python3'


#CDPATH=.:~:~/work:~/work/idsapps
