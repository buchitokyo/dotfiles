export ZSH_DISABLE_COMPFIX=true
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"

# alias 
alias la="ls -a"
alias ll="ls -lh"
alias ls='ls -G'
export LSCOLORS=gxfxcxdxbxegedabagacad

PROMPT='[%n@%m]# '
RPROMPT='[%d]'
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# zplugの設定
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# zshのフレームワーク
zplug "sorin-ionescu/prezto"

# syntax
zplug "chrissicool/zsh-256color"
zplug "b4b4r07/enhancd", use:init.sh
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "ascii-soup/zsh-url-highlighter"
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplugの設定ここまで

# prezto用のプラグイン
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/homebrew", from:prezto
zplug "modules/ruby", from:prezto

#zpreztoの初期化
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# pure
autoload -Uz promptinit && promptinit
prompt pure

# 未インストールのプラグインがあるときのみインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# >>>実行
export PURE_HOME=$HOME"/.zprezto/modules/prompt/external/pure"
source $PURE_HOME/pure.zsh
