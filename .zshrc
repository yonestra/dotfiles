export LANG=ja_JP.UTF-8

# PROMPT
#PROMPT="%/%% "
#PROMPT2="%_%% "
#SPROMPT="%r is correct? [n,y,a,e]: "
#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#  PROMPT="${HOST%%.*} ${PROMPT}"
#;;

PROMPT="%%"
RPROMPT="[%~]"
SPROMPT="correct:%R -> %r?"

# Path Setting
path=(/bin /usr/local/bin /usr/bin)

alias ls="ls -G"
alias la="ls -a"
alias ll="ls -la"

alias gs="git status"
alias add="git add"
alias pull"git pull"
alias push="git push"
alias cm="git commit"

alias emac="open -a /Applications/Emacs.app/Contents/MacOS/Emacs"

alias grep='grep --color=auto'