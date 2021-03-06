# test
export LANG=ja_JP.UTF-8

HISTSIZE=1000
SAVEHIST=1000

export HISTFILE=~/.history/history.`date +%y%m%d%H%M`

# PROMPT
autoload colors
colors
PROMPT="%{${fg[white]}%}%(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="[%~]%{${reset_color}%}"
REPORTTIME=3

alias vi="vim"
alias ls="ls"
alias la="ls -a"
alias ll="ls -la"
alias grep="grep -n --color=auto"

alias ff="find . -type f -print | xargs grep -n --color=auto"
function rr() {
     rsync -arvp --cvs-exclude $* ./dir2/$*
}

alias gs="git status"
alias add="git add"
alias pull="git pull"
alias push="git push"
alias cm="git commit"
alias gl="git log --oneline"
alias gd="git diff"
alias gb="git branch"


alias grep='grep --color=auto'

# sudo でPATHを引き継ぐ
alias sudo='sudo env PATH=$PATH'

## terminal configuration
#

export TERM="xterm-256color"

export LSCOLORS=exfxcxdxbxegedabagacad$
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

autoload -U compinit && compinit -u
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

autoload -Uz zmv
alias zmv='noglob zmv -W'

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

#補完数が多い時に許可を聞く閾値$
LISTMAX=100

case "${OSTYPE}" in

    #Mac(Unix)
    darwin*)

    #-------------------------Mac------------------------------

    alias emac="open -a /Applications/Emacs.app/Contents/MacOS/Emacs"
    alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

    alias gvi="open -a /Applications/MacVim.app/Contents/MacOS/MacVim"

    alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"

    # http://takus.me/programming/perl/mac-perl-perlblew-cpanm-install/
    # perlbrew
#     source $HOME/perl5/perlbrew/etc/bashrc
    # perlコマンドやperldocコマンドを実行したときにインストールしたディレクトリを見つけられるように環境変数をつける
#    export PERL5LIB=$HOME/perl5/lib/perl5

    # rvmの設定
    if [[ -s $HOME/.rvm/scripts/rvm ]] then
        source $HOME/.rvm/scripts/rvm
    fi


    alias ctags="/usr/local/Cellar/ctags/5.8/bin/ctags"
    alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"

    # Path Setting
    path=(/Users/yonezawa/AndroidSDK/platform-tools /sbin /bin /usr/local/bin /usr/bin ~/bin)

    export ARCHFLAGS="-arch x86_64"
    export CC='gcc-4.2'

    alias hello="echo Hello Mac";

    ;;

linux*)

    alias hello="echo Hello Linux";

    setopt nonomatch
    source /usr/local/nvm/nvm.sh
    nvm use v0.8.18
    npm_dir=${NVM_PATH}_modules
    export NODE_PATH=$npm_dir

    ;;
esac

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


export PATH="/usr/local/opt/openssl/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export CC=/usr/bin/gcc

#Rails ローカルproductionチェック用
export RAILS_SERVE_STATIC_FILES=1
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export BUNDLE_JOBS=4
