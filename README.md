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
brew install sheldon starship eza neovim lazygit tmux \
  yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick \
  font-symbols-only-nerd-font tree-sitter tree-sitter-cli
```

| ツール | 用途 |
|--------|------|
| [Sheldon](https://github.com/rossmacarthur/sheldon) | zsh プラグイン管理（Rust製、高速） |
| [Starship](https://starship.rs/) | プロンプト（Rust製、高速） |
| [eza](https://github.com/eza-community/eza) | ls の代替（Rust製、アイコン表示） |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー |
| [Neovim](https://neovim.io/) | モダンな Vim（LSP対応） |
| [lazygit](https://github.com/jesseduffield/lazygit) | ターミナル用 Git UI |
| [yazi](https://yazi-rs.github.io/) | ターミナル用ファイルマネージャ（Rust製、高速） |
| [tmux](https://github.com/tmux/tmux) | ターミナルマルチプレクサ（セッション管理・画面分割） |
| [Ghostty](https://ghostty.org/) | モダンなターミナル（Rust製、GPU加速） |
| [tree-sitter](https://tree-sitter.github.io/) | パーサーライブラリ + CLI（Neovim の treesitter パーサーコンパイルに必要） |

#### yazi 依存ツール

| ツール | 用途 |
|--------|------|
| [ffmpeg](https://ffmpeg.org/) | 動画サムネイルプレビュー |
| [7-Zip](https://www.7-zip.org/) | アーカイブプレビュー |
| [jq](https://jqlang.github.io/jq/) | JSON プレビュー |
| [poppler](https://poppler.freedesktop.org/) | PDF プレビュー |
| [fd](https://github.com/sharkdp/fd) | ファイル検索（yazi内部で使用） |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | テキスト検索（yazi内部で使用） |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | スマートディレクトリジャンプ |
| [ImageMagick](https://imagemagick.org/) | 画像プレビュー |
| [Nerd Font (Symbols)](https://www.nerdfonts.com/) | アイコン表示用フォント |

### 5. Rust / Cargo ツールをインストール

```zsh
# Rust をインストール
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Cargo ツール
cargo install keifu filetree
```

| ツール | 用途 |
|--------|------|
| [keifu](https://github.com/Syu-fu/keifu) | Git コミット履歴の系譜表示 |
| [filetree](https://github.com/solidiquis/filetree) | ファイルツリー表示 |

### 6. dotfiles をインストール

```zsh
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 7. シェルを再起動

```zsh
exec zsh
```

## ファイル構成

```
dotfiles/
├── .zshrc                      # zsh 設定
├── .tmux.conf                  # tmux 設定
├── .config/
│   ├── sheldon/
│   │   └── plugins.toml        # プラグイン管理
│   └── starship.toml           # プロンプト設定
├── nvim/                       # Neovim 設定（~/.config/nvim にリンク）
│   ├── init.lua
│   └── lua/
│       ├── core/               # 基本設定・キーマップ
│       ├── config/             # lazy.nvim 設定
│       └── plugins/            # プラグイン設定
├── ghostty/                    # Ghostty 設定（~/.config/ghostty にリンク）
│   └── config
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
  - `y` : yazi（終了時にディレクトリ移動）

### yazi（ファイルマネージャ）

`y` コマンドで起動。終了時（`q`）にyazi内で開いていたディレクトリにcdする。

#### 基本操作

| キー | 機能 |
|------|------|
| `j` / `k` | 上下移動 |
| `l` / `Enter` | ディレクトリに入る / ファイルを開く |
| `h` | 親ディレクトリに戻る |
| `q` | 終了（現在のディレクトリにcd） |
| `Q` | 終了（ディレクトリ移動なし） |
| `~` | ホームディレクトリへ |
| `.` | 隠しファイルの表示切り替え |

#### ファイル操作

| キー | 機能 |
|------|------|
| `y` | ヤンク（コピー対象を選択） |
| `x` | カット（移動対象を選択） |
| `p` | ペースト（コピー/移動を実行） |
| `d` | 削除（ゴミ箱） |
| `D` | 完全削除 |
| `a` | 新規ファイル作成 |
| `r` | リネーム |
| `Space` | 選択 / 選択解除 |

#### 検索・ジャンプ

| キー | 機能 |
|------|------|
| `/` | 検索 |
| `f` | フィルター |
| `z` | fzf でジャンプ |
| `g` + `t` / `d` / `h` | /tmp / ~/Downloads / ~ へジャンプ |

#### 表示

| キー | 機能 |
|------|------|
| `1` / `2` / `3` | ソート切り替え |
| `Tab` | プレビュー切り替え |
| `w` | タスク一覧 |

### fzf（ファジーファインダー）

あいまい検索でファイルや履歴を素早く見つける。

| キー / コマンド | 機能 |
|----------------|------|
| `Ctrl+h` | コマンド履歴を検索（zshで設定済み） |
| `\` | カレント以下のファイルを検索して挿入 |
| `Ctrl+r` | コマンド履歴を検索（fzf デフォルト） |
| `Alt+c` | ディレクトリを検索してcd |
| `**<Tab>` | パス補完（例: `vim **<Tab>`） |

### zoxide（スマートcd）

移動履歴を学習して、少ないキー入力でディレクトリ移動できる。

| コマンド | 機能 |
|---------|------|
| `z foo` | 過去に移動した `foo` を含むディレクトリへジャンプ |
| `z foo bar` | `foo` と `bar` 両方を含むパスへジャンプ |
| `zi` | fzf で移動先を対話的に選択 |
| `z -` | 直前のディレクトリに戻る |

### vim

- プラグインなしの軽量構成
- undo 永続化（~/.vim/undo/）
- スペースキーをリーダーキーに設定
- 主なキーマップ：
  - `Space w` : 保存
  - `Space q` : 終了
  - `jj` : ESC
  - `H` / `L` : 行頭 / 行末

### Neovim

- Lua ベースのモダンな設定
- **LSP対応**（関数ジャンプ、補完、リネーム等）
- プラグインマネージャ: lazy.nvim
- 詳細なキー操作は [チートシート](nvim/CHEATSHEET.md) を参照
- hlchunk.nvim（インデントブロックのハイライト）
- noice.nvim（コマンドライン・通知のポップアップ UI）
- which-key.nvim（キーバインドヘルプ表示）
- Snacks.nvim（ファジーピッカー・インデントガイド）
- oil.nvim（ファイルエクスプローラー）
- dropbar.nvim（パンくずリスト）
- nvim-treesitter-context（関数/クラスのコンテキスト固定表示）
- nvim-scrollbar（スクロールバー + 診断マーク）
- accelerated-jk.nvim（j/k 加速移動）
- comment-box（コメントボックス作成）
- namu.nvim（シンボルナビゲーション）
- tiny-inline-diagnostic（エラー/警告のインライン表示）

#### 対応言語（LSP）

- TypeScript / JavaScript（ts_ls）
- Python（pyright）
- Lua（lua_ls）

#### 主なキーマップ

`Space` がリーダーキー（`<leader>`）。`Space ff` は `Space` → `f` → `f` と順番に押す。`;` でコマンドモード（`:` の代わり）。

| キー | 機能 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント |
| `Space rn` | リネーム |
| `Space ca` | コードアクション |
| `[d` / `]d` | 診断メッセージ移動 |
| `Space ff` | ファイル検索（Snacks Picker） |
| `Space fg` | 文字列検索（Snacks Picker） |
| `u` | 元に戻す（Undo） |
| `Ctrl+r` | やり直し（Redo） |
| `s` + 文字 + ラベル | Flash ジャンプ（画面内の任意の位置に2-3キーで移動） |
| `Space ai` | AI アシスタント（Sidekick） |
| `Space aa` | AI アシスタント（Avante） |
| `Space ?` | キーバインド一覧（which-key） |
| `Space gg` | LazyGit（Git UI） |
| `yy` | 行コピー（ヤンク） |
| `yw` | 単語をヤンク |
| `y$` | カーソルから行末までヤンク |
| `y^` | カーソルから行頭までヤンク |
| `yi"` | `"..."` の中身をヤンク |
| `yi'` | `'...'` の中身をヤンク |
| `yi(` | `(...)` の中身をヤンク |
| `yi{` | `{...}` の中身をヤンク |
| `yi[` | `[...]` の中身をヤンク |
| `yit` | HTMLタグの中身をヤンク |
| `yiw` | カーソル上の単語をヤンク |
| `yap` | 段落をヤンク（空行含む） |
| `2yy` | 2行ヤンク（数字は任意） |
| `p` / `P` | 貼り付け（下/上） |
| `/検索語` | 前方検索 |
| `n` / `N` | 次/前の検索結果 |
| `*` / `#` | カーソル下の単語を検索 |

#### エイリアス

- `vim` / `vi` → `nvim`

### Ghostty

- GPU加速のモダンなターミナル
- テーマ: Catppuccin（ダーク/ライト自動切り替え）
- フォント: JetBrains Mono

#### 主なキーバインド

| キー | 機能 |
|------|------|
| `Cmd+D` | 右にスプリット |
| `Cmd+Shift+D` | 下にスプリット |
| `Ctrl+Cmd+H/J/K/L` | スプリット間移動 |
| `Cmd+↑` / `Cmd+↓` | プロンプト間ジャンプ |
| `Cmd+Shift+,` | 設定リロード |

### tmux（ターミナルマルチプレクサ）

セッション管理・ペイン分割でターミナル作業を効率化。Prefix は `Ctrl+b`（デフォルト）。

#### 基本操作

| キー | 機能 |
|------|------|
| `prefix + v` | 左右にペイン分割 |
| `prefix + s` | 上下にペイン分割 |
| `prefix + c` | 新規ウィンドウ |
| `prefix + x` | ペインを閉じる |
| `prefix + H/J/K/L` | ペインリサイズ（左/下/上/右） |
| `prefix + Escape` | コピーモード（vi キーバインド） |
| `v` (コピーモード) | 選択開始 |
| `y` (コピーモード) | コピー（pbcopy） |

#### セッション管理（ターミナルから実行）

| コマンド | 機能 |
|---------|------|
| `tmux` | 新規セッション起動 |
| `tmux new -s 名前` | 名前付きセッション作成 |
| `tmux ls` | セッション一覧 |
| `tmux a` | 最後のセッションに復帰 |
| `tmux a -t 名前` | 指定セッションに復帰 |
| `tmux kill-session -t 名前` | セッション削除 |

#### セッション操作（tmux 内）

| キー | 機能 |
|------|------|
| `prefix + d` | セッションからデタッチ（抜ける） |
| `prefix + $` | セッション名を変更 |
| `prefix + w` | セッション/ウィンドウ一覧（プレビュー付き） |
| `prefix + (` / `)` | 前/次のセッションに切り替え |

#### fzf 連携

| キー | 機能 |
|------|------|
| `prefix + F` | tmux-fzf 起動（セッション/ウィンドウ等を操作） |
| `prefix + W` | ウィンドウ選択（fzf） |
| `prefix + P` | ペイン選択（fzf） |

#### プラグイン

| プラグイン | 起動キー | 機能 |
|-----------|---------|------|
| [tpm](https://github.com/tmux-plugins/tpm) | `prefix + I` | プラグインインストール |
| [tmux-fzf](https://github.com/sainnhe/tmux-fzf) | `prefix + F` | fzf で tmux 操作 |
| [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) | `prefix + Space` | 画面上のテキストをクイックコピー |
| [tmux-session-wizard](https://github.com/27medkamal/tmux-session-wizard) | `prefix + T` | セッション作成・切り替え（fzf） |
| [extrakto](https://github.com/laktak/extrakto) | `prefix + Tab` | 画面上のテキストを抽出・挿入 |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | `prefix + Ctrl-s/r` | セッション保存・復元 |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | 自動 | セッション自動保存 |

#### セットアップ

```zsh
# install.sh が tpm を自動クローン
./install.sh

# tmux 起動後、プラグインをインストール
tmux
# prefix + I（Ctrl+b → Shift+i）
```

#### CCStatusBar（Claude Code セッションモニター）

1. [Releases](https://github.com/usedhonda/cc-status-bar/releases) から CCStatusBar.dmg をダウンロード
2. DMG を開き、CCStatusBar.app を Applications にドラッグ
3. Applications から起動
4. アクセシビリティ権限を許可
5. セットアップウィザードに従う

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

### `command not found: sheldon` / `starship` / `nvim`

ツールがインストールされていない：

```zsh
brew install sheldon starship neovim
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

### Neovim の LSP が動かない

ヘルスチェックを実行：

```zsh
nvim
:checkhealth
```

LSP サーバーを手動インストール：

```zsh
nvim
:Mason
```
