---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  keys = {
    -- f系（従来のTelescope互換）
    { "<Leader>ff",       function() Snacks.picker.files() end,          desc = "Find files" },
    { "<Leader>fg",       function() Snacks.picker.grep() end,           desc = "Live grep" },
    { "<Leader>fb",       function() Snacks.picker.buffers() end,        desc = "Buffers" },
    { "<Leader>fw",       function() Snacks.picker.grep_word() end,      desc = "Grep word",         mode = { "n", "v" } },
    { "<Leader>fh",       function() Snacks.picker.help() end,           desc = "Help tags" },
    { "<Leader>fr",       function() Snacks.picker.lsp_references() end, desc = "LSP references" },
    { "<Leader>fs",       function() Snacks.picker.lsp_symbols() end,    desc = "Document symbols" },
    -- s系（Snacks Picker拡張）
    { "<Leader><Leader>", function() Snacks.picker.smart() end,          desc = "Smart picker" },
    { "<Leader>sf",       function() Snacks.picker.files() end,          desc = "Find files" },
    { "<Leader>sg",       function() Snacks.picker.grep() end,           desc = "Grep" },
    { "<Leader>sw",       function() Snacks.picker.grep_word() end,      desc = "Grep cursor word" },
    { "<Leader>sb",       function() Snacks.picker.buffers() end,        desc = "Buffers" },
    { "<Leader>sr",       function() Snacks.picker.recent() end,         desc = "Recent files" },
    { "<Leader>sc",       function() Snacks.picker.commands() end,       desc = "Commands" },
    { "<Leader>sh",       function() Snacks.picker.help() end,           desc = "Help" },
    { "<Leader>sk",       function() Snacks.picker.keymaps() end,        desc = "Keymaps" },
    { "<Leader>sd",       function() Snacks.picker.diagnostics() end,    desc = "Diagnostics" },
    { "<Leader>ss",       function() Snacks.picker.lsp_symbols() end,    desc = "LSP symbols" },
    { "<Leader>sR",       function() Snacks.picker.resume() end,         desc = "Resume last picker" },
  },
  opts = {
    picker = {
      enabled = true,
    },
    indent = {
      enabled = false,
    },
    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        keys = {
          { icon = " ", key = "f", desc = "Find File",    action = function() Snacks.picker.files() end },
          { icon = " ", key = "r", desc = "Recent Files",  action = function() Snacks.picker.recent() end },
          { icon = " ", key = "g", desc = "Find Text",     action = function() Snacks.picker.grep() end },
          { icon = " ", key = "c", desc = "Config",        action = function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end },
          { icon = "󰒲 ", key = "l", desc = "Lazy",          action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit",          action = ":qa" },
        },
      },
    },
  },
}
---@diagnostic enable: undefined-global
