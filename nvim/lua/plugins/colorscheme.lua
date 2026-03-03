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
        custom_highlights = function(C)
          return {
            -- キーワード（if, for, def, return, import）を鮮やかに
            ["@keyword"] = { fg = C.mauve, bold = true },
            ["@keyword.function"] = { fg = C.mauve, bold = true },
            ["@keyword.return"] = { fg = C.mauve, bold = true },
            ["@keyword.import"] = { fg = C.mauve, bold = true },

            -- 関数名をはっきり
            ["@function"] = { fg = C.blue, bold = true },
            ["@function.call"] = { fg = C.blue },
            ["@function.builtin"] = { fg = C.peach },
            ["@method.call"] = { fg = C.blue },

            -- 変数
            ["@variable"] = { fg = C.flamingo },
            ["@variable.parameter"] = { fg = C.maroon },
            ["@variable.member"] = { fg = C.lavender },

            -- プロパティ・フィールド
            ["@property"] = { fg = C.lavender },
            ["@field"] = { fg = C.lavender },

            -- 型・クラス
            ["@type"] = { fg = C.yellow, bold = true },
            ["@type.builtin"] = { fg = C.yellow },

            -- 文字列をよりはっきり
            ["@string"] = { fg = C.green },

            -- 定数・数値
            ["@constant"] = { fg = C.peach },
            ["@constant.builtin"] = { fg = C.peach, bold = true },
            ["@number"] = { fg = C.peach },
            ["@boolean"] = { fg = C.peach, bold = true },

            -- 組み込み変数（self 等）
            ["@variable.builtin"] = { fg = C.red },

            -- 演算子
            ["@operator"] = { fg = C.sky },

            -- デコレータ
            ["@attribute"] = { fg = C.teal, bold = true },
          }
        end,
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
