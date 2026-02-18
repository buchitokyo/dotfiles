return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "rmehri01/onenord.nvim",
    "lewis6991/gitsigns.nvim",
    "SmiteshP/nvim-navic",
  },
  config = function()
    local colors = require("onenord.colors").load()

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          "branch",
          "diff",
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 0,
            symbols = { modified = "_󰷥", readonly = " ", newfile = "󰄛", unnamed = "[No Name]" },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = {
              "nvim_diagnostic",
              "nvim_lsp",
            },
            sections = {
              "error",
              "warn",
              "info",
              "hint",
            },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = {
              fg = "#ff9e64",
            },
          },
          "encoding",
        },
        lualine_y = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            color = {
              fg = colors.fg,
            },
          },
          "progress",
        },
        lualine_z = {
          "location",
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = "",
              dos = "",
              mac = "",
            },
            separator = {
              left = "",
              right = "",
            },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
