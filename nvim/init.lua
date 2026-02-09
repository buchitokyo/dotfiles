-- Neovim configuration
-- Migrated from .vimrc

-- Load core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load plugin manager and plugins
require("config.lazy")
