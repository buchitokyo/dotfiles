#!/bin/bash
# devcontainerの起動＋ツールセットアップ
# devcontainer-nvim.sh から呼ばれる

set -e

WORKSPACE_FOLDER="$(cd "$(dirname "$0")/.." && pwd)"
DOTFILES_REPO="https://github.com/buchitokyo/dotfiles.git"

# コンテナ起動
devcontainer up --workspace-folder "$WORKSPACE_FOLDER"

# ツールセットアップ（未セットアップの場合のみ）
devcontainer exec --workspace-folder "$WORKSPACE_FOLDER" \
  bash -c "
    # 基本パッケージインストール
    if ! which unzip > /dev/null 2>&1 || ! which gcc > /dev/null 2>&1; then
      apt-get update && apt-get install -y ripgrep fd-find curl unzip gcc g++ make tmux jq
    fi

    # herdr（エージェントマルチプレクサ / dev-layout.sh が jq を使う）
    which herdr > /dev/null 2>&1 || curl -fsSL https://herdr.dev/install.sh | sh

    # tree-sitter CLIインストール（nvim-treesitterのパーサーコンパイルに必須）
    which tree-sitter > /dev/null 2>&1 || npm install -g tree-sitter-cli

    # nvimインストール（0.11+が必要なため最新stableをGitHubからAppImage経由で取得）
    which nvim > /dev/null 2>&1 || (
      curl -fLo /tmp/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.appimage
      chmod +x /tmp/nvim.appimage
      cd /tmp && /tmp/nvim.appimage --appimage-extract > /dev/null 2>&1
      mv /tmp/squashfs-root /opt/nvim
      ln -sf /opt/nvim/usr/bin/nvim /usr/local/bin/nvim
      rm /tmp/nvim.appimage
    )

    # yazi & yaインストール
    which yazi > /dev/null 2>&1 || (
      curl -fLo /tmp/yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-aarch64-unknown-linux-gnu.zip
      unzip -o /tmp/yazi.zip -d /tmp/yazi
      mv /tmp/yazi/yazi-aarch64-unknown-linux-gnu/yazi /usr/local/bin/
      mv /tmp/yazi/yazi-aarch64-unknown-linux-gnu/ya /usr/local/bin/
      chmod +x /usr/local/bin/yazi /usr/local/bin/ya
      rm -rf /tmp/yazi /tmp/yazi.zip
    )

    # lazygitインストール
    which lazygit > /dev/null 2>&1 || (
      LAZYGIT_VERSION=\$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -oP '\"tag_name\":\\s*\"v\\K[^\"]+')
      curl -fLo /tmp/lazygit.tar.gz \"https://github.com/jesseduffield/lazygit/releases/download/v\${LAZYGIT_VERSION}/lazygit_\${LAZYGIT_VERSION}_Linux_arm64.tar.gz\"
      tar xzf /tmp/lazygit.tar.gz -C /tmp lazygit
      mv /tmp/lazygit /usr/local/bin/
      chmod +x /usr/local/bin/lazygit
      rm -f /tmp/lazygit.tar.gz
    )

    # SSH known_hosts設定（GitHub）
    if [ ! -f \"\$HOME/.ssh/known_hosts\" ] || ! grep -q github.com \"\$HOME/.ssh/known_hosts\" 2>/dev/null; then
      mkdir -p \"\$HOME/.ssh\"
      ssh-keyscan github.com >> \"\$HOME/.ssh/known_hosts\" 2>/dev/null
    fi

    # gitユーザー設定
    git config --global user.name 2>/dev/null || (
      git config --global user.name 'Hirotoshi Kawabuchi'
      git config --global user.email 'hirotoshi.kawabuchi@gmail.com'
    )

    # dotfilesクローン＆セットアップ
    if [ ! -d \"\$HOME/dotfiles\" ]; then
      git clone $DOTFILES_REPO \"\$HOME/dotfiles\"
      if [ -f \"\$HOME/dotfiles/install.sh\" ]; then
        cd \"\$HOME/dotfiles\" && bash install.sh
      else
        mkdir -p \"\$HOME/.config\"
        ln -sf \"\$HOME/dotfiles/nvim\" \"\$HOME/.config/nvim\"
        ln -sf \"\$HOME/dotfiles/tmux\" \"\$HOME/.config/tmux\"
        ln -sf \"\$HOME/dotfiles/yazi\" \"\$HOME/.config/yazi\"
        mkdir -p \"\$HOME/.config/herdr\"
        ln -sf \"\$HOME/dotfiles/herdr/config.toml\" \"\$HOME/.config/herdr/config.toml\"
      fi
    fi

    # yaziプラグインインストール
    if [ ! -d \"\$HOME/.local/state/yazi/packages\" ] || [ -z \"\$(ls -A \"\$HOME/.local/state/yazi/packages\" 2>/dev/null)\" ]; then
      ya pkg add yazi-rs/plugins:git
    fi

    # nvimプラグインインストール＋treesitterパーサーコンパイル
    if [ -f \"\$HOME/dotfiles/scripts/compile-treesitter-parsers.sh\" ] && [ ! -d \"\$HOME/.local/share/nvim/site/parser\" ] || [ -z \"\$(ls -A \"\$HOME/.local/share/nvim/site/parser\" 2>/dev/null)\" ]; then
      nvim --headless '+Lazy! sync' +qa 2>/dev/null || true
      bash \"\$HOME/dotfiles/scripts/compile-treesitter-parsers.sh\"
    fi
  "
