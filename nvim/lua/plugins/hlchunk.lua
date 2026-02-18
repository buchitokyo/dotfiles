return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        style = {
          { fg = "#61afef" },
          { fg = "#e06c75" },
        },
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        textobject = "ic",
        duration = 150,
        delay = 200,
      },
      indent = {
        enable = true,
        chars = { "│", "¦", "┆", "┊" },
        style = {
          { fg = "#3b4048" },
        },
      },
      line_num = {
        enable = true,
        style = "#61afef",
        use_treesitter = true,
      },
      blank = {
        enable = true,
        chars = { "·" },
        style = {
          { fg = "#5c6370" },
        },
      },
    })
  end,
}
