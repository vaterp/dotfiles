HOST=$(uname -n)
echo "I'm running on $HOST /  $OSTYPE / $BASH_VERSION"

#
#Bash Setup
#
bind Space:magic-space #Expand History Commands with space
export HISTCONTROL="ignoreboth:erasedups"   #Don't put duplicate lines or lines starting with space in history
export HISTIGNORE="exit:history:ls:l:clear:cls"
#HISTSIZE=1000
#HISTFILESIZE=1000
#PROMPT_COMMAND+=( 'history -a') #write it right away
#PROMPT_COMMAND+=( 'history -n' ) #read it right away
#PS0="$PS0"'$(history -a)'
unset MAILCHECK
EDITOR=vim

shopt -s histverify #Allow for verification with a substituted history expansion
shopt -s autocd
shopt -s globstar #Pattern "**" matches pathnaem expansion

export CDPATH=.:~:~/work
FIGNORE='~:.o:.d:.a:'
export BAT_THEME="ansi"

#Only for MAC
if [[ $(uname -s) == "Darwin" ]]; then
  export PATH="/Users/brian.snyder/.local/bin:/opt/homebrew/bin:$PATH"
  PS1='\u@\h:\w ($HISTCMD)$'
  alias te='open -a TextEdit'
fi

#
#General Aliases
#
alias cat='bat --paging=never'
alias tls='tmux list-session'
alias hu='history -n'  #Merge history from other shells
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
alias pp="pstree -ph"
alias du='du -hsc'
alias df='df -h'
alias j=jobs
alias c=clear
#LS aliases...
alias l='ls'
alias la='ls -A'
alias lla='ls -hArtl --color=auto'
alias ll='ls -hrtl --color=auto'
alias ls='ls -hF --color=auto'
alias cl="clear; ls"
alias cll="clear; ll"
alias cla="clear; lla"

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
#Python Helpers
#
alias sv="source .venv/bin/activate"
alias webshare='python3 -m SimpleHTTPServer 8080'
alias p='python3'

#
#Some Function helpers
#
function toptar ()
{  # Only show top level directories in a tar file
   tar --exclude='*/*' -tf $1
}
function repeat() {
  for ((n=0;n<$1;n++))
  do
    eval ${*:2}
    done
}
function highlight {
  grep -E "^|.*$1.*"
}
#
#Docker Helpers
#
alias wdc='watch docker container ls -all'
alias dil="docker image ls"
