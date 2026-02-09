-- Key mappings (migrated from .vimrc)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================
-- 一般
-- ============================================
-- ; でコマンドモード（Shift不要）
keymap("n", ";", ":", { noremap = true })

-- ESC連打でハイライト解除
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", opts)

-- 折り返し行でも見た目通りに移動
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)

-- 行頭・行末移動を楽に
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)

-- ============================================
-- ウィンドウ操作
-- ============================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ============================================
-- バッファ操作
-- ============================================
keymap("n", "<Leader>n", ":bnext<CR>", opts)
keymap("n", "<Leader>p", ":bprevious<CR>", opts)
keymap("n", "<Leader>d", ":bdelete<CR>", opts)

-- ============================================
-- タブ操作
-- ============================================
keymap("n", "<Leader>t", ":tabnew<CR>", opts)
keymap("n", "<Leader>]", ":tabnext<CR>", opts)
keymap("n", "<Leader>[", ":tabprevious<CR>", opts)

-- ============================================
-- ファイル操作
-- ============================================
keymap("n", "<Leader>w", ":w<CR>", opts)
keymap("n", "<Leader>q", ":q<CR>", opts)
keymap("n", "<Leader>x", ":x<CR>", opts)

-- 全選択
keymap("n", "<Leader>a", "ggVG", opts)

-- ============================================
-- ビジュアルモード
-- ============================================
-- インデント後も選択維持
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ヤンク後もカーソル位置維持
keymap("v", "y", "y`]", opts)

-- ============================================
-- インサートモード
-- ============================================
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-a>", "<Home>", opts)
keymap("i", "<C-e>", "<End>", opts)

-- jj でESC
keymap("i", "jj", "<Esc>", opts)
keymap("i", "っj", "<Esc>", opts)

-- ============================================
-- 便利コマンド
-- ============================================
-- 現在のファイルのディレクトリに移動
keymap("n", "<Leader>cd", ":cd %:h<CR>:pwd<CR>", opts)

-- 設定ファイル編集・再読み込み
keymap("n", "<Leader>ev", ":edit $MYVIMRC<CR>", opts)
keymap("n", "<Leader>sv", ":source $MYVIMRC<CR>", opts)

-- 末尾の空白を削除
keymap("n", "<Leader>ss", [[:%s/\s\+$//e<CR>]], opts)

-- ============================================
-- 相対行番号の切り替え（モード対応）
-- ============================================
keymap("n", "v", ":set norelativenumber<CR>v", opts)
keymap("n", "V", ":set norelativenumber<CR>V", opts)
keymap("n", "<C-v>", ":set norelativenumber<CR><C-v>", opts)
keymap("v", "<Esc>", "<Esc>:set relativenumber<CR>", opts)
