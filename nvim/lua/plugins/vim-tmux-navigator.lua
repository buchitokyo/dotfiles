-- Neovim スプリット ↔ tmux ペインのシームレス移動
-- herdr 内では読み込まない（herdr は Ctrl+Alt+h/j/k/l でペイン移動し、
-- Ctrl+h/j/k/l は Neovim の分割移動として core/keymaps.lua が割り当てる）
return {
  "christoomey/vim-tmux-navigator",
  cond = vim.env.HERDR_ENV ~= "1",
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Navigate left" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Navigate down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Navigate up" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
  },
}
