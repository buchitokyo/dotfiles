# dotfiles

## セットアップ手順

### 1. リポジトリをクローン

```zsh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

### 2. Homebrew インストール（未インストールの場合）

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Sheldon と Starship をインストール

```zsh
brew install sheldon starship
```

### 4. dotfiles をインストール

```zsh
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 5. 新しいシェルを起動

```zsh
exec zsh
```

## ファイル構成

```
dotfiles/
├── .zshrc                      # zsh設定
├── .config/
│   ├── sheldon/
│   │   └── plugins.toml        # プラグイン管理
│   └── starship.toml           # プロンプト設定
├── .vimrc                      # vim設定
├── .gvimrc                     # gvim設定
├── .vim/                       # vimプラグイン等
└── install.sh                  # インストールスクリプト
```

## 使用ツール

| ツール | 用途 |
|--------|------|
| [Sheldon](https://github.com/rossmacarthur/sheldon) | zshプラグイン管理（Rust製、高速） |
| [Starship](https://starship.rs/) | プロンプト（Rust製、高速） |

## プラグイン一覧

- zsh-autosuggestions（入力補完候補）
- zsh-syntax-highlighting（シンタックスハイライト）
- zsh-completions（追加の補完）
- zsh-history-substring-search（履歴検索）
- enhancd（cd強化）

## カスタマイズ

### プロンプトの変更

`~/.config/starship.toml` を編集

参考: https://starship.rs/config/

### プラグインの追加

`~/.config/sheldon/plugins.toml` を編集後、キャッシュを削除:

```zsh
rm ~/.cache/sheldon.zsh
exec zsh
```

## トラブルシューティング

### `command not found: brew`

Homebrew のパスが通っていない。以下を実行:

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 起動が遅い場合

起動時間を計測:

```zsh
time zsh -i -c exit
```

50〜100ms程度が目安。
