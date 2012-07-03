# test
export LANG=ja_JP.UTF-8


# PROMPT
autoload colors
colors
PROMPT="%{${fg[yellow]}%}%(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="[%~]%{${reset_color}%}"

# Path Setting
path=(/bin /usr/local/bin /usr/bin)

alias vi="vim"
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
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

alias grep='grep --color=auto'

## terminal configuration
#

export LSCOLORS=exfxcxdxbxegedabagacad$
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

autoload -U compinit && compinit
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

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

# rvmの設定
if [[ -s $HOME/.rvm/scripts/rvm ]] then
    source $HOME/.rvm/scripts/rvm
fi
