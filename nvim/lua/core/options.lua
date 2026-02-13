-- Basic options (migrated from .vimrc)

local opt = vim.opt

-- ============================================
-- 基本設定
-- ============================================
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.backup = false
opt.swapfile = false
opt.autoread = true
opt.hidden = true
opt.showcmd = true
opt.autoindent = true
opt.smartindent = true

-- undo永続化
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undo")

-- 履歴
opt.history = 10000

-- ============================================
-- 見た目
-- ============================================
opt.number = true
opt.relativenumber = false

opt.cursorline = true
opt.virtualedit = "onemore"
opt.visualbell = true
opt.showmatch = true
opt.matchtime = 1
opt.laststatus = 2
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.wrap = true
opt.display = "lastline"

-- シンタックス
opt.termguicolors = true
opt.background = "dark"

-- ============================================
-- ステータスライン
-- ============================================
opt.statusline = "%F%m%r%h%w%=[%{&fileencoding}][%{&fileformat}][%Y] %l/%L (%p%%)"

-- ============================================
-- Tab / インデント
-- ============================================
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", extends = "»", precedes = "«", lead = "·" }

-- ============================================
-- 検索
-- ============================================
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.wrapscan = true
opt.hlsearch = true

-- ============================================
-- クリップボード
-- ============================================
opt.clipboard = "unnamedplus"

-- ============================================
-- マウス
-- ============================================
opt.mouse = "a"

-- ============================================
-- 補完
-- ============================================
opt.wildmode = "list:longest,full"
opt.wildmenu = true
opt.completeopt = "menuone,noinsert,noselect"

-- ============================================
-- その他
-- ============================================
-- undoディレクトリ作成
local undo_dir = vim.fn.expand("~/.vim/undo")
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cursor のスタイルを適用するために guicursor を設定
opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- netrw 無効化（neo-tree が代替）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
