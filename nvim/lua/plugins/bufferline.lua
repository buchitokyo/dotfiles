return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo Tree",
          text_align = "center",
          highlight = "Directory",
          separator = true,
        },
      },
      always_show_bufferline = true,
    },
  },
}
