return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          neotree = true,
          lualine = {},
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
