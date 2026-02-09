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
-- ハイライト on yank
-- ============================================
local highlight_yank = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
  group = highlight_yank,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
