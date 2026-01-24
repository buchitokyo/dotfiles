# dotfiles

macOS 用の dotfiles（Apple Silicon 対応）

## 新しい Mac でのセットアップ

### 1. Homebrew をインストール

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

インストール後、パスを通す：

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Git をインストール（Xcode Command Line Tools）

```zsh
xcode-select --install
```

### 3. リポジトリをクローン

```zsh
git clone git@github.com:buchitokyo/dotfiles.git ~/dotfiles
```

### 4. 必要なツールをインストール

```zsh
brew install sheldon starship eza fzf
```

| ツール | 用途 |
|--------|------|
| [Sheldon](https://github.com/rossmacarthur/sheldon) | zsh プラグイン管理（Rust製、高速） |
| [Starship](https://starship.rs/) | プロンプト（Rust製、高速） |
| [eza](https://github.com/eza-community/eza) | ls の代替（Rust製、アイコン表示） |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー |

### 5. dotfiles をインストール

```zsh
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 6. シェルを再起動

```zsh
exec zsh
```

## ファイル構成

```
dotfiles/
├── .zshrc                      # zsh 設定
├── .config/
│   ├── sheldon/
│   │   └── plugins.toml        # プラグイン管理
│   └── starship.toml           # プロンプト設定
├── .vimrc                      # vim 設定
├── .gvimrc                     # gvim 設定（GUI版vim）
├── .vim/                       # vim プラグイン等
├── .gitignore                  # Git 除外設定
├── install.sh                  # インストールスクリプト
└── README.md
```

## 主な機能

### zsh

- **プラグイン（Sheldon）**
  - zsh-autosuggestions（入力補完候補）
  - zsh-syntax-highlighting（シンタックスハイライト）
  - zsh-completions（追加の補完）
  - enhancd（cd 強化）

- **キーバインド**
  - `Ctrl+h` : 履歴検索（fzf）
  - `Ctrl+f` : ghq リポジトリ移動（fzf）

- **エイリアス**
  - `ls` / `la` / `ll` / `lt` : eza（アイコン付き）
  - `l` : 画面クリア + ls
  - `wttr [都市名]` : 天気予報

### vim

- プラグインなしの軽量構成
- undo 永続化（~/.vim/undo/）
- スペースキーをリーダーキーに設定
- 主なキーマップ：
  - `Space w` : 保存
  - `Space q` : 終了
  - `jj` : ESC
  - `H` / `L` : 行頭 / 行末

### gvim（GUI版vim、オプション）

- vim 設定を継承
- メニュー・ツールバー非表示（シンプル）
- 使わない場合は `.gvimrc` を削除してOK

## カスタマイズ

### プロンプトの変更

```zsh
vi ~/.config/starship.toml
```

参考: https://starship.rs/config/

### プラグインの追加・削除

```zsh
vi ~/.config/sheldon/plugins.toml
```

編集後、キャッシュを再生成：

```zsh
rm ~/.cache/sheldon.zsh
exec zsh
```

## トラブルシューティング

### `command not found: brew`

Homebrew のパスが通っていない：

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### `command not found: sheldon` / `starship`

ツールがインストールされていない：

```zsh
brew install sheldon starship
```

### プラグインが反映されない

キャッシュを削除：

```zsh
rm ~/.cache/sheldon.zsh
exec zsh
```

### 起動が遅い場合

起動時間を計測：

```zsh
time zsh -i -c exit
```

50〜100ms 程度が目安。
