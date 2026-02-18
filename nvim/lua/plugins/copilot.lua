return {
  -- copilot.lua
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  -- copilot-cmp
  {
    "zbirenbaum/copilot-cmp",
    event = "VimEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
