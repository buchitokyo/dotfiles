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
# NOTE: tmux は herdr への移行期間中のみ残している（移行完了後に削除する）
for dir in nvim tmux ghostty sheldon; do
    [ -d "$dir" ] && ln -snfv ${PWD}/"$dir" ~/.config/"$dir"
done

# 単体ファイル
[ -f "starship/starship.toml" ] && ln -snfv ${PWD}/starship/starship.toml ~/.config/starship.toml

# herdr（ログ・ソケット・session.json を同じディレクトリに書き込むためファイル単位でリンク）
if [ -d "herdr" ]; then
    mkdir -p ~/.config/herdr
    for f in herdr/*; do
        ln -snfv ${PWD}/"$f" ~/.config/herdr/
    done
fi

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

# herdr: Claude Code 連携フック（~/.claude/hooks/herdr-agent-state.sh を生成し、
# settings.json に SessionStart フックを追記する）
if command -v herdr >/dev/null 2>&1; then
    herdr integration install claude
fi

# tmux プラグインマネージャ（tpm）
# NOTE: herdr への移行期間中のみ残している（移行完了後に削除する）
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tpm (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
