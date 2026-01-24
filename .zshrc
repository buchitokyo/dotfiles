# ============================================
# 基本設定
# ============================================
export LANG=ja_JP.UTF-8
export ZSH_DISABLE_COMPFIX=true
setopt nonomatch

# ============================================
# PATH設定
# ============================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/Cellar/mysql@5.7/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
eval "$(/opt/homebrew/bin/brew shellenv)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ============================================
# 履歴設定
# ============================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history

# ============================================
# 補完設定
# ============================================
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ============================================
# ls / ディレクトリ移動
# ============================================
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

alias la="ls -a"
alias ll="ls -lh"
alias ls='ls -G'

# 天気予報
alias wttr='(){ curl -H "Accept-Language: ${LANG%_*}" --compressed "wttr.in/${1:-Tokyo}" }'

# cd後に自動でls
function chpwd() { ls -A -G -F }

# ============================================
# Sheldon (プラグイン) - キャッシュ版
# ============================================
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"

if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p "$cache_dir"
  sheldon source > "$sheldon_cache"
fi
source "$sheldon_cache"

# ============================================
# キーバインド (history-substring-search用)
# ============================================
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# ============================================
# Starship プロンプト
# ============================================
eval "$(starship init zsh)"

# ============================================
# 開発環境
# ============================================
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# nodenv
if command -v nodenv &> /dev/null; then
  eval "$(nodenv init -)"
fi

# conda (miniforge)
if [ -f "$HOME/miniforge3/bin/conda" ]; then
  __conda_setup="$("$HOME/miniforge3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
          . "$HOME/miniforge3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/miniforge3/bin:$PATH"
      fi
  fi
  unset __conda_setup
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


