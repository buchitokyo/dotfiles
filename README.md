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
  font-symbols-only-nerd-font tree-sitter tree-sitter-cli \
  nodenv node-build
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

### 6. Node.js 環境をセットアップ

```zsh
# nodenv をインストール
brew install nodenv node-build

# シェルに nodenv を初期化（.zshrc に記載済み）
eval "$(nodenv init -)"

# Node.js をインストール
nodenv install 22.17.0
nodenv global 22.17.0
```

グローバル npm パッケージをインストール：

```zsh
npm install -g @anthropic-ai/claude-code ccmanager
```

| ツール | 用途 |
|--------|------|
| [nodenv](https://github.com/nodenv/nodenv) | Node.js バージョン管理 |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | AI コーディングアシスタント（CLI） |
| [ccmanager](https://github.com/jasonjmcghee/ccmanager) | Claude Code の並行セッション管理（`npx ccmanager` で利用） |

### 7. dotfiles をインストール

```zsh
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### 8. シェルを再起動

```zsh
exec zsh
```

## ファイル構成

```
dotfiles/
├── nvim/                       # Neovim（~/.config/nvim）
│   ├── init.lua
│   └── lua/
│       ├── core/               # 基本設定・キーマップ
│       ├── config/             # lazy.nvim 設定
│       └── plugins/            # プラグイン設定
├── tmux/                       # tmux（~/.config/tmux）
│   ├── tmux.conf
│   ├── toggle-claude-pane.sh   # Claude Code ペイントグル
│   └── yazi-popup.sh           # yazi ポップアップ
├── ghostty/                    # Ghostty（~/.config/ghostty）
│   └── config
├── sheldon/                    # zsh プラグイン管理（~/.config/sheldon）
│   └── plugins.toml
├── yazi/                       # yazi ファイルマネージャ（~/.config/yazi）
│   ├── init.lua
│   └── yazi.toml
├── starship.toml               # プロンプト（~/.config/starship.toml）
├── claude/                     # Claude Code（~/.claude）
│   └── settings.json
├── .zshrc                      # zsh 設定（~/）
├── .vimrc                      # vim 設定（~/）
├── .gvimrc                     # gvim 設定（~/）
├── .vim/                       # vim プラグイン等（~/）
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

#### プラグインのインストール

```zsh
ya pack -a yazi-rs/plugins:git
```

Git リポジトリ内のファイル/ディレクトリに Git ステータスを表示する。

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

#### タブ操作

| キー | 機能 |
|------|------|
| `t` | 新しいタブを作成 |
| `[` / `]` | 前/次のタブに移動 |
| `{` / `}` | タブを前/次の位置にスワップ |

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
#### UI / 表示
| プラグイン | 用途 | キー |
|-----------|------|------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | ステータスライン（モード・ファイル名・診断・filetype） | - |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | タブ/バッファライン（neo-tree オフセット対応） | `Tab` / `S-Tab` |
| [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) | winbar パンくずリスト（クリック可能なパス表示） | - |
| [noice.nvim](https://github.com/folke/noice.nvim) | コマンドライン・検索のポップアップ UI | - |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | キーバインドヘルプ表示 | `Space ?` |
| [hlchunk.nvim](https://github.com/shellRaining/hlchunk.nvim) | インデントブロックのハイライト | - |
| [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar) | スクロールバー + 診断マーク | - |
| [tiny-inline-diagnostic](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | エラー/警告のインライン表示 | - |

#### ファイル管理
| プラグイン | 用途 | キー |
|-----------|------|------|
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | サイドバー型ファイルツリー（git ステータス色表示） | `Space E` |
| [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | フローティング型ファイルマネージャ | `-` / `Space e` |
| [close-buffers.nvim](https://github.com/kazhala/close-buffers.nvim) | バッファ一括削除（他/非表示/全） | `Space bo/bh/ba` |

#### 検索 / ナビゲーション
| プラグイン | 用途 | キー |
|-----------|------|------|
| [Snacks.nvim](https://github.com/folke/snacks.nvim) | ファジーピッカー（ファイル・grep・バッファ等） | `Space ff/fg/fb` |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | 診断・LSP 結果のリスト表示 | `Space xx/xX/cs/cl` |
| [namu.nvim](https://github.com/bassamsdata/namu.nvim) | シンボルナビゲーション | `Space ns` |
| [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) | 検索ハイライト強化 | - |

#### コーディング支援
| プラグイン | 用途 | キー |
|-----------|------|------|
| [nvim-navic](https://github.com/SmiteshP/nvim-navic) | LSP パンくずリスト | - |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | 関数/クラスのコンテキスト固定表示 | - |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) + copilot-cmp | GitHub Copilot 補完 | - |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | コメントトグル | `gcc` / `gc` |
| [comment-box](https://github.com/LudoPinelli/comment-box.nvim) | コメントボックス作成 | `Space cb/cl` |
| [accelerated-jk.nvim](https://github.com/rainbowhxch/accelerated-jk.nvim) | j/k 加速移動 | `j` / `k` |

#### Git
| プラグイン | 用途 | キー |
|-----------|------|------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 行単位の git 差分・hunk 操作 | `Space hs/hr/hp` |

#### 対応言語（LSP）

- TypeScript / JavaScript（typescript-tools.nvim）
- Python（basedpyright）
- Lua（lua_ls）
- Terraform（terraformls）

#### 主なキーマップ

`Space` がリーダーキー（`<leader>`）。`Space ff` は `Space` → `f` → `f` と順番に押す。`;` でコマンドモード（`:` の代わり）。

| キー | 機能 |
|------|------|
| `Space w` | 保存 |
| `Space q` | 終了 |
| `Space x` | 保存して終了 |
| `jj` | ESC（インサートモード） |
| `H` / `L` | 行頭 / 行末（ノーマル・ビジュアル） |
| `gg` / `G` | ファイル先頭 / 末尾 |
| `数字G` / `:数字` | 指定行にジャンプ（例: `42G`、`:42`） |
| `Esc Esc` | 検索ハイライト解除 |
| `Space a` | 全選択 |
| `Ctrl+h/j/k/l` | ウィンドウ移動 |
| `Space d` | バッファ削除 |
| `Space t` | 新規タブ |
| `Space cd` | 現在のファイルのディレクトリに移動 |
| `Space ss` | 末尾の空白を削除 |
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント |
| `Space rn` | リネーム |
| `Space ca` | コードアクション |
| `[d` / `]d` | 診断メッセージ移動 |
| `Tab` / `S-Tab` | 次/前のバッファ |
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

セッション管理・ペイン分割でターミナル作業を効率化。Prefix は `Ctrl+a`。

#### 基本操作

| キー | 機能 |
|------|------|
| `prefix + v` | 左右にペイン分割 |
| `prefix + s` | 上下にペイン分割 |
| `prefix + c` | 新規ウィンドウ |
| `prefix + x` | ペインを閉じる |
| `prefix + &` | ウィンドウを閉じる |
| `prefix + H/J/K/L` | ペインリサイズ（左/下/上/右） |
| `Alt+←` / `Alt+→` | ペイン移動（端でウィンドウ跨ぎ） |
| `Alt+c` | Claude Code ペインにトグル |
| `prefix + y` | yazi ポップアップ（ディレクトリ同期） |
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
| `tmux switch -t 名前or番号` | セッション切り替え（tmux 内から） |

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
