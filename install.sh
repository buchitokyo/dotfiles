#!/bin/sh
set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

# ==============================================================================
# ホームディレクトリ向けドットファイル（.zshrc, .vimrc 等 → ~/）
# ==============================================================================
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    ln -snfv ${PWD}/"$f" ~/
done

# ==============================================================================
# ~/.config 向け設定（ディレクトリ単位でシンボリックリンク）
# ==============================================================================
mkdir -p ~/.config

# ディレクトリごとリンク
for dir in nvim tmux ghostty sheldon; do
    [ -d "$dir" ] && ln -snfv ${PWD}/"$dir" ~/.config/"$dir"
done

# 単体ファイル
[ -f "starship.toml" ] && ln -snfv ${PWD}/starship.toml ~/.config/starship.toml

# Yazi（plugins/package.toml は ya pkg が管理するためファイル単位でリンク）
if [ -d "yazi" ]; then
    mkdir -p ~/.config/yazi
    for f in yazi/*; do
        ln -snfv ${PWD}/"$f" ~/.config/yazi/
    done
fi

# ==============================================================================
# その他
# ==============================================================================
# Claude Code 設定（~/.claude/settings.json）
if [ -d "claude" ]; then
    mkdir -p ~/.claude
    ln -snfv ${PWD}/claude/settings.json ~/.claude/settings.json
fi

# tmux プラグインマネージャ（tpm）
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tpm (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
