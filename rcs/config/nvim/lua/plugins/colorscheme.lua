-- Colorschemes
local utils = require("functions")
local settings = require("user-settings")

return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if utils.safeRead(settings.themeMethod, "builtin") == "plugin"
        and utils.safeRead(settings.theme, "default") == "onedark"
      then
        require('onedark').setup({
          style = utils.safeRead(settings.themeVariant, "dark")
        })

        require('onedark').load()
      end
    end,
  },
  {
    "lunarvim/darkplus.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if utils.safeRead(settings.themeMethod, "builtin") == "plugin"
        and utils.safeRead(settings.theme, "default") == "darkplus"
      then
        require('darkplus').load()
      end
    end,
  },
  {
    "lunarvim/onedarker.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if utils.safeRead(settings.themeMethod, "builtin") == "plugin"
        and utils.safeRead(settings.theme, "default") == "onedarker"
      then
        require('onedarker').load()
      end
    end,
  },
}
