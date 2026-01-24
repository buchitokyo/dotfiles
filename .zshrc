export ZSH_DISABLE_COMPFIX=true
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH=$PATH:'/mnt/c/Users/hirotoshikawabuchi/AppData/Local/Programs/Microsoft VS Code/bin'

# alias 
alias la="ls -a"
alias ll="ls -lh"
alias ls='ls -G'
export LSCOLORS=gxfxcxdxbxegedabagacad

# cdの後にlsを実行
#Mac用の設定
export CLICOLOR=1
function chpwd() { ls -A -G -F}

autoload -Uz vcs_info
setopt prompt_subst
setopt nonomatch

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd(){ vcs_info }

# PROMPT='[%n@%m]# '
# RPROMPT='[%d]'
# RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# zplugの設定
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
 
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


# pure
# autoload -Uz promptinit
# promptinit
# prompt pure

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
source ~/enhancd/init.sh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"
export PATH="~/anaconda3/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hirotoshikawabuchi/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hirotoshikawabuchi/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/hirotoshikawabuchi/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hirotoshikawabuchi/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(nodenv init -)"
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/opt/homebrew/Cellar/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
# pip EB CLI
export PATH="$HOME/.local/bin:$PATH"

# port
# for ((i=2; i<256; i++))
# do
#    sudo ifconfig lo0 alias 127.0.0.$i up
# done

# bun completions
[ -s "/Users/hirotoshikawabuchi/.bun/_bun" ] && source "/Users/hirotoshikawabuchi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
