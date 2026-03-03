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

            -- LSP セマンティックトークン（treesitter と同じ色を適用）
            ["@lsp.type.variable"] = { fg = C.flamingo },
            ["@lsp.type.variable.python"] = { fg = C.flamingo },
            ["@lsp.type.parameter"] = { fg = C.maroon },
            ["@lsp.type.property"] = { fg = C.lavender },
            ["@lsp.type.function"] = { fg = C.blue, bold = true },
            ["@lsp.type.method"] = { fg = C.blue },
            ["@lsp.type.class"] = { fg = C.yellow, bold = true },
            ["@lsp.type.decorator"] = { fg = C.teal, bold = true },
            ["@lsp.type.keyword"] = { fg = C.mauve, bold = true },
            ["@lsp.type.string"] = { fg = C.green },
            ["@lsp.type.number"] = { fg = C.peach },
            ["@lsp.type.operator"] = { fg = C.sky },
            ["@lsp.mod.readonly"] = {},
            ["@lsp.typemod.variable.readonly"] = { fg = C.peach },
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
