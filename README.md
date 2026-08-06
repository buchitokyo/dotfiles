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
brew install sheldon starship eza neovim lazygit herdr tmux \
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
| [herdr](https://herdr.dev/) | エージェントマルチプレクサ（セッション管理・画面分割 + エージェント状態表示） |
| [tmux](https://github.com/tmux/tmux) | ターミナルマルチプレクサ（herdr への移行期間中のみ） |
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
npm install -g @anthropic-ai/claude-code
```

| ツール | 用途 |
|--------|------|
| [nodenv](https://github.com/nodenv/nodenv) | Node.js バージョン管理 |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | AI コーディングアシスタント（CLI） |

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
│       └── plugins/            # プラグイン設定（プラグインごとに分割）
├── herdr/                      # herdr（~/.config/herdr、ファイル単位でリンク）
│   ├── config.toml
│   ├── dev-layout.sh           # 開発用 4 ペインレイアウト
│   └── yazi-popup.sh           # yazi ポップアップ
├── tmux/                       # tmux（~/.config/tmux、移行期間中のみ）
│   ├── tmux.conf
│   ├── dev-layout.sh
│   ├── toggle-claude-pane.sh   # Claude Code ペイントグル
│   └── yazi-popup.sh           # yazi ポップアップ
├── ghostty/                    # Ghostty（~/.config/ghostty）
│   └── config
├── sheldon/                    # zsh プラグイン管理（~/.config/sheldon）
│   └── plugins.toml
├── yazi/                       # yazi ファイルマネージャ（~/.config/yazi）
│   ├── init.lua
│   └── yazi.toml
├── starship/                   # プロンプト
│   └── starship.toml           # → ~/.config/starship.toml にリンク
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
| [Snacks.nvim](https://github.com/folke/snacks.nvim) | ファジーピッカー・ダッシュボード | `Space ff/fg/fb` |
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

#### ナビゲーション連携
| プラグイン | 用途 | キー |
|-----------|------|------|
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Neovim スプリット ↔ tmux ペイン間のシームレス移動（herdr 内では無効） | `Ctrl+h/j/k/l` |

herdr 内（`HERDR_ENV=1`）では vim-tmux-navigator を読み込まず、`Ctrl+h/j/k/l` は Neovim の分割移動のみに使う。herdr ペイン間の移動は `Ctrl+Alt+h/j/k/l` または `prefix+h/j/k/l`。

#### Git
| プラグイン | 用途 | キー |
|-----------|------|------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 行単位の git 差分・hunk 操作 | `Space hs/hr/hp` |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff / マージ / ファイル履歴 | `Space gd/gh/gH` |

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
| `Ctrl+h/j/k/l` | ウィンドウ移動（herdr 内は Neovim 分割のみ / tmux 内は vim-tmux-navigator） |
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

#### Cmd キーパススルー（Neovim 連携）

Ghostty → マルチプレクサ → Neovim の経路で Cmd キーを転送。Neovim 内で IDE 風のショートカットが使える。

Ghostty は `keybind = cmd+s=csi:115;9u` の形で **CSI u 形式**（`\e[<codepoint>;<mod>u`、mod 9 = super / 10 = super+shift）を送る（`ghostty/config`）。

- **herdr** — 中継設定は不要。herdr は起動時に `\e[>7u` で kitty keyboard protocol を要求し、受け取ったキーを Super 修飾として解釈、kitty keyboard protocol を有効にしたペイン（Neovim 等）へ CSI u 形式で再エンコードして渡す。
  - ⚠️ herdr が解釈するのは **CSI u 形式のみ**。旧設定の `csi:115;9~`（`\e[...~`）は黙って破棄され、Neovim には何も届かない。Cmd キーが全滅したらまずここを疑う。
- **tmux** — CSI u をそのまま渡さないため、`tmux.conf` の `user-keys` + `bind-key -n User*`（28行）による変換が必要。ただし現在の `tmux/tmux.conf` は Ghostty が `\e[...~` を送る前提のままなので、tmux に戻す場合は `user-keys` の文字列を `u` 形式に合わせること。

ただしシェルのペインは kitty keyboard protocol を有効にしないため、herdr は Super 修飾を落として素のキーを渡す。zsh で `Cmd+S` を押すと `s` が入力される（tmux では `.zshrc` の `bindkey -s` で吸収していた）。

| キー | Neovim での動作 |
|------|------|
| `Cmd+S` | 保存 |
| `Cmd+Z` | undo |
| `Cmd+Y` | redo |
| `Cmd+P` | 割り当て可能 |
| `Cmd+B` | 割り当て可能 |
| `Cmd+/` | 割り当て可能 |
| `Cmd+J` | 割り当て可能 |
| `Cmd+Shift+F` | 割り当て可能 |
| `Cmd+Shift+P` | 割り当て可能 |
| `Cmd+Shift+J` | 割り当て可能 |
| `` Cmd+` `` | 割り当て可能 |

### herdr（エージェントマルチプレクサ）

tmux の後継。セッション管理・ペイン分割に加えて、各ペインで動く AI エージェントの状態（idle / working / blocked / done）をサイドバーに表示する。Prefix は `Ctrl+a`。

階層は **Workspace > Tab > Pane**（tmux の Session > Window > Pane に対応）。

```zsh
herdr                       # 起動 / 既存セッションにアタッチ
herdr --session work        # 名前付きセッション
herdr --remote you@server   # SSH 越しにリモートの herdr へアタッチ
herdr config check          # config.toml の検証
herdr server reload-config  # 設定リロード（prefix+Shift+R でも可）
```

#### 開発用レイアウト（`dev` コマンド）

4ペイン構成で開発環境を一発起動（`herdr/dev-layout.sh`）。`jq` が必要。

```
┌──────────────┬──────────────┐
│              │              │
│    nvim      │    claude    │
│   (60%)      │   (40%)      │
│              │              │
├──────────────┼──────────────┤
│    shell     │    shell     │
│   (30%)      │   (30%)      │
└──────────────┴──────────────┘
```

| コマンド | 機能 |
|---------|------|
| `dev` | カレントディレクトリで起動（Workspace 名 = ディレクトリ名） |
| `dev ~/code/proj` | ディレクトリ指定 |
| `dev ~/code/proj myname` | ディレクトリ + Workspace 名指定 |
| `prefix + Shift+E` | herdr 内から現在のディレクトリでレイアウト起動 |

同名 Workspace が既にあればフォーカスするだけ（tmux の `has-session` 相当）。複数プロジェクトは Workspace 名を変えて並行起動し、`prefix + w` または `prefix + Shift+1..9` で切り替える。

**herdr の中から新しい Workspace を開く場合**も、任意のペインで `dev [DIR] [LABEL]` を叩けばよい。`HERDR_ENV=1` を見て最後の `exec herdr`（アタッチ）をスキップするので、現在のクライアントのまま新 Workspace に切り替わり、herdr が入れ子にならない。herdr の外から実行した場合はレイアウトを組んでからアタッチする。

レイアウト不要で claude だけの Workspace が欲しいときは `cc [DIR]`（`.zshrc`）。

#### 基本操作

| キー | 機能 |
|------|------|
| `prefix + v` | 左右にペイン分割 |
| `prefix + s` / `prefix + -` | 上下にペイン分割 |
| `prefix + c` | 新規タブ |
| `prefix + x` | ペインを閉じる |
| `prefix + Shift+X` | タブを閉じる |
| `prefix + h/j/k/l` | ペイン移動 |
| `Ctrl+Alt+h/j/k/l` | ペイン移動（prefix なし） |
| `prefix + Shift+H/J/K/L` | ペイン入れ替え |
| `prefix + r` | リサイズモード（入ってから `h/j/k/l`） |
| `prefix + z` | ペインをズーム |
| `prefix + n` / `p` | 次 / 前のタブ |
| `prefix + 1..9` | タブ番号で切り替え |
| `prefix + b` | サイドバー表示切替 |
| `prefix + q` | デタッチ（プロセスは動き続ける） |
| `prefix + ?` | 有効なキーバインド一覧 |

#### エージェント操作

| キー | 機能 |
|------|------|
| `prefix + Alt+1..9` | エージェントペインに直行 |
| `prefix + Alt+n` / `Alt+p` | 次 / 前のエージェント |
| `prefix + o` | 通知元のペインを開く |

サイドバーの状態アイコン: 🔴 blocked（承認・入力待ち）/ 🟡 working / 🔵 done（未確認）/ 🟢 idle / ⚪ エージェント以外。

`herdr integration install claude` で Claude Code 連携フックを導入する（`install.sh` が自動実行）。これにより `~/.claude/hooks/herdr-agent-state.sh` が生成され、`claude/settings.json` に `SessionStart` フックが追記される。サーバ再起動後は `claude --resume` でセッションが自動復帰する。

#### Workspace 管理

| キー | 機能 |
|------|------|
| `prefix + w` | Workspace ピッカー |
| `prefix + g` | Goto ピッカー（Workspace / Tab / Pane を横断） |
| `prefix + Shift+N` | 新規 Workspace |
| `prefix + Shift+W` | Workspace 名変更 |
| `prefix + Shift+D` | Workspace を閉じる |
| `prefix + Shift+G` | git worktree を新規 Workspace として開く |

#### コピーモード

`prefix + [` または `prefix + Escape` で開始。vi キーバインドは**組み込み**（tmux のような個別設定は不要かつ不可）。

| キー | 機能 |
|------|------|
| `h/j/k/l`・`w/b/e`・`{`/`}` | 移動 |
| `Ctrl+b` / `Ctrl+f` | ページ単位で移動 |
| `/` / `?` → `n` / `N` | 検索 / 次・前へ |
| `v` / `Space` | 選択開始 |
| `y` / `Enter` | コピー |
| `q` / `Esc` | コピーせず離脱 |

Prefix を `Ctrl+a` にしているため、コピーモード内で `Ctrl+b`（ページアップ）が使える。マウスドラッグはコピーモードに入らずそのままコピーされる（`copy_on_select`）。

#### マウス選択とコピー（未解決）

`[ui] mouse_capture = true` にしているため herdr がマウス入力を掴む。その結果 **Ghostty のネイティブ選択（ドラッグ → `Cmd+C`）が効かない**。

回避策と選択肢は次の通り。どれを既定にするかは未決定。

| 方法 | 挙動 |
|------|------|
| `Shift` + ドラッグ | herdr のマウス捕捉をバイパスして Ghostty 側の選択に切り替わる。`Cmd+C` でコピー |
| 通常のドラッグ | herdr が選択して自動コピー（`copy_on_select`）。OSC 52 経由で macOS のクリップボードへ渡す |
| `prefix + [` → `v` → `y` | コピーモードで選択してコピー |

`mouse_capture = false` にすれば Ghostty のネイティブ選択と `Cmd` クリックでの URL 開きが戻るが、引き換えに herdr のペイン/タブのクリック切り替えと境界線ドラッグでのリサイズが使えなくなる（キーバインドは全て使える）。

参考: tmux でも `set -g mouse on` で同じトレードオフがあった。

#### ポップアップ

| キー | 機能 |
|------|------|
| `prefix + y` | yazi（終了時に元ペインを `cd`） |
| `prefix + Alt+g` | lazygit |
| `prefix + t` | 使い捨てシェル |

#### CLI / ソケット API

エージェント自身がマルチプレクサを操作できる。tmux の `send-keys` 相当に加えて待機処理がある。出力は JSON。

```zsh
herdr pane list                                   # ペイン一覧
herdr pane split w1:p1 --direction right --ratio 0.6
herdr pane run w1:p2 "npm run dev"
herdr pane read w1:p2                             # ペインの出力を読む
herdr pane wait-output w1:p2 --match "ready on port 3000"
herdr agent status --wait --until done
```

#### セッションの永続化

| ケース | プロセス継続 | レイアウト復元 |
|--------|------------|--------------|
| デタッチ → 再アタッチ | ○ | ○ |
| サーバ再起動 | ✗ | ○（cwd 込み。エージェントは `--resume` で復帰） |

tmux-resurrect / continuum のような追加プラグインは不要。ペインの画面内容まで復元したい場合は `[experimental] pane_history = true`（出力に秘密情報が残る点に注意）。

#### tmux から移行しなかったもの

| tmux | 状況 |
|------|------|
| ステータスバーの cpu / battery / uptime | **代替なし**。サイドバーがエージェント状態と git ブランチを表示する |
| `prefix + V` / `prefix + S`（分割して手前に挿入） | 方向指定のみのため非対応 |
| copy-mode のキー個別再定義 | vi 操作は組み込みだがカスタム不可 |
| tmux-fzf / thumbs / session-wizard / extrakto | 公式マーケットプレイスのプラグインで代替可（未導入） |

プラグインは `herdr plugin install owner/repo` で導入する（`--yes` で非対話）。一覧は https://herdr.dev/plugins/ 。レビュー機構はないため、導入前に中身を確認する。

#### セットアップ

```zsh
brew install herdr
./install.sh   # config.toml / スクリプトをリンクし、Claude Code 連携を導入
herdr
```

ライセンスは AGPL-3.0 と商用のデュアル。個人利用は問題ないが、外部へのサービス提供に組み込む場合は商用ライセンスを確認する。

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
