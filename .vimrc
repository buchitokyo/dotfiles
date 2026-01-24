" ============================================
" 基本設定
" ============================================
set fenc=utf-8
set encoding=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set autoindent
set smartindent

" undo永続化
set undofile
set undodir=~/.vim/undo

" 履歴
set history=10000

" ============================================
" 見た目
" ============================================
set number
set relativenumber          " 相対行番号（5jで5行移動など便利）

" モードに応じて行番号表示を切り替え
augroup NumberToggle
  autocmd!
  " ノーマルモード: 相対行番号
  autocmd InsertLeave,WinEnter,BufEnter * if &number | set relativenumber | endif
  " 挿入モード: 絶対行番号
  autocmd InsertEnter,WinLeave,BufLeave * if &number | set norelativenumber | endif
augroup END

" ビジュアルモード: 絶対行番号に切り替え
nnoremap <silent> v :set norelativenumber<CR>v
nnoremap <silent> V :set norelativenumber<CR>V
nnoremap <silent> <C-v> :set norelativenumber<CR><C-v>
" ビジュアルモード終了時: 相対行番号に戻す
vnoremap <silent> <Esc> <Esc>:set relativenumber<CR>

set cursorline
" set cursorcolumn          " 縦線は重くなるのでコメントアウト
set virtualedit=onemore
set visualbell
set showmatch
set matchtime=1             " 括弧マッチを0.1秒で表示
set laststatus=2
set scrolloff=5             " スクロール時に上下5行確保
set sidescrolloff=5
set wrap                    " 行の折り返し
set display=lastline        " 長い行も表示

" シンタックス
syntax enable
set background=dark
colorscheme molokai

" ============================================
" ステータスライン（プラグインなし）
" ============================================
set statusline=%F                           " ファイル名
set statusline+=%m                          " 変更あり [+]
set statusline+=%r                          " 読み取り専用 [RO]
set statusline+=%h                          " ヘルプ
set statusline+=%w                          " プレビュー
set statusline+=%=                          " 右寄せ
set statusline+=[%{&fileencoding}]          " 文字コード
set statusline+=[%{&fileformat}]            " 改行コード
set statusline+=[%Y]                        " ファイルタイプ
set statusline+=\ %l/%L                     " 行番号/総行数
set statusline+=\ (%p%%)                    " 割合

" ============================================
" Tab / インデント
" ============================================
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list listchars=tab:▸\ ,trail:·,extends:»,precedes:«

" ============================================
" 検索
" ============================================
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" ============================================
" クリップボード
" ============================================
set clipboard=unnamed,unnamedplus

" ============================================
" マウス
" ============================================
set mouse=a
if !has('nvim')
  set ttymouse=sgr          " xterm2より新しい形式
endif

" ============================================
" 補完
" ============================================
set wildmode=list:longest,full
set wildmenu
set completeopt=menuone,noinsert

" ============================================
" キーマッピング
" ============================================
" リーダーキーをスペースに
let mapleader = "\<Space>"

" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR>

" 折り返し行でも見た目通りに移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 行頭・行末移動を楽に
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" バッファ移動
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>d :bdelete<CR>

" タブ操作
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>] :tabnext<CR>
nnoremap <Leader>[ :tabprevious<CR>

" ファイル保存・終了
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>

" 全選択
nnoremap <Leader>a ggVG

" インデント後も選択維持
vnoremap < <gv
vnoremap > >gv

" ヤンク後もカーソル位置維持
vnoremap y y`]

" 入力モードでのカーソル移動
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" jj でESC
inoremap jj <Esc>
inoremap っj <Esc>

" ============================================
" 便利コマンド
" ============================================
" 現在のファイルのディレクトリに移動
nnoremap <Leader>cd :cd %:h<CR>:pwd<CR>

" vimrc編集・再読み込み
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" 末尾の空白を削除
nnoremap <Leader>ss :%s/\s\+$//e<CR>

" ============================================
" ファイルタイプ別設定
" ============================================
augroup FileTypeSettings
  autocmd!
  " Python
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  " Makefile
  autocmd FileType make setlocal noexpandtab
  " Markdown
  autocmd FileType markdown setlocal wrap
augroup END

" ============================================
" その他
" ============================================
" undoディレクトリ作成
if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), 'p')
endif

" 最後に開いた位置を記憶
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
augroup END

