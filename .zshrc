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
alias pull="git pull"
alias push="git push"
alias cm="git commit"
alias gl="git log --oneline"
alias gd="git diff"
alias gb="git branch"

alias emac="open -a /Applications/Emacs.app/Contents/MacOS/Emacs"

alias grep='grep --color=auto'

## terminal configuration
#

export LSCOLORS=exfxcxdxbxegedabagacad$
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

#補完数が多い時に許可を聞く閾値$
LISTMAX=100

# http://takus.me/programming/perl/mac-perl-perlblew-cpanm-install/
# perlbrew
source $HOME/perl5/perlbrew/etc/bashrc
# perlコマンドやperldocコマンドを実行したときにインストールしたディレクトリを見つけられるように環境変数をつける
export PERL5LIB=$HOME/perl5/lib/perl5

