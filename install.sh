#!/bin/sh
set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

# ドットファイルのシンボリックリンク（既存の処理）
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".config" ] && continue  # .configは別処理
    ln -snfv ${PWD}/"$f" ~/
done

# .config 以下の処理
if [ -d ".config" ]; then
    mkdir -p ~/.config
    for dir in .config/*; do
        ln -snfv ${PWD}/"$dir" ~/.config/
    done
fi

# Neovim設定
if [ -d "nvim" ]; then
    mkdir -p ~/.config
    ln -snfv ${PWD}/nvim ~/.config/nvim
fi

# Ghostty設定
if [ -d "ghostty" ]; then
    mkdir -p ~/.config
    ln -snfv ${PWD}/ghostty ~/.config/ghostty
fi

# Claude Code設定
if [ -d "claude" ]; then
    mkdir -p ~/.claude
    ln -snfv ${PWD}/claude/settings.json ~/.claude/settings.json
fi

# tmux プラグインマネージャ（tpm）
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tpm (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
