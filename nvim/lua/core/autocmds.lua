-- Auto commands (migrated from .vimrc)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================
-- 最後に開いた位置を記憶
-- ============================================
local restore_cursor = augroup("RestoreCursor", { clear = true })

autocmd("BufReadPost", {
  group = restore_cursor,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] >= 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- ============================================
-- ファイルタイプ別設定
-- ============================================
local filetype_settings = augroup("FileTypeSettings", { clear = true })

-- Python
autocmd("FileType", {
  group = filetype_settings,
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})

-- Makefile
autocmd("FileType", {
  group = filetype_settings,
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false
  end,
})

-- Markdown
autocmd("FileType", {
  group = filetype_settings,
  pattern = "markdown",
  callback = function()
    vim.wo.wrap = true
  end,
})

-- ============================================
-- カーソル & 選択範囲ハイライト（パステルカラー）
-- ============================================
local custom_hl = augroup("CustomHighlights", { clear = true })

autocmd("ColorScheme", {
  group = custom_hl,
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#1e1e2e", bg = "#94e2d5" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a3a" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#94e2d5", bold = true })
    vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2a2a3a" })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#45475a", fg = "#cdd6f4" })

    -- neo-tree: git ステータスの色を見やすく
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#9ece6a", bold = true })     -- 追加: 緑
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#e0af68", bold = true })  -- 変更: 黄
    vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#f7768e", bold = true })   -- 削除: 赤
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#ff9e64", bold = true }) -- 未追跡: オレンジ
    vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#f7768e", bold = true })  -- コンフリクト: 赤
    vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#e0af68" })               -- unstaged: 黄
    vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = "#9ece6a" })                 -- staged: 緑
    -- neo-tree: フォルダアイコンの色
    vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#7aa2f7" })
  end,
})

-- ============================================
-- 保存時に自動フォーマット（LSP）
-- ============================================
local format_on_save = augroup("FormatOnSave", { clear = true })

autocmd("BufWritePre", {
  group = format_on_save,
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local has_formatter = vim.iter(clients):any(function(c)
      return c.supports_method("textDocument/formatting")
    end)
    if has_formatter then
      vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
    end
  end,
})

-- ============================================
-- ハイライト on yank
-- ============================================
local highlight_yank = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
  group = highlight_yank,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
