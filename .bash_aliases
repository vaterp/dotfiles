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

shopt -s autocd
export CDPATH=~:~/work
FIGNORE='~:.o:.d:.a:CVS'

shopt -s globstar #Pattern "**" matches pathnaem expansion
unset MAILCHECK
EDITOR=vi

#
#Aliases
#
alias tls='tmux list-session'
alias hu='history -n'  #Merge history from other shells
alias d='diff'
alias diff='diff -w --side-by-side --suppress-common-lines'
alias g='grep'
alias gi='grep -i'
alias gl='grep -l'
alias vi='vim -O'
alias writeable='find . -type f -perm -u+w'
alias exe='find . -type f -perm -u+x'
alias fn='find . -name'
alias f='find . -type f -print0 | xargs -0 grep'
alias fw='find . -type f -print0 | xargs -0 grep -w '


function highlight {
  grep -E "^|.*$1.*"
}

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

alias webshare='python -m SimpleHTTPServer 8080'
alias p='python3'

