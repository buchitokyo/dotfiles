-- sidekick.nvim: AI assistant in Neovim (by folke)
-- Requires: Neovim >= 0.11.2, Claude CLI or other AI CLI tools
return {
  {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<Leader>ai", "<cmd>Sidekick<cr>", desc = "Open Sidekick" },
    },
  },
}
