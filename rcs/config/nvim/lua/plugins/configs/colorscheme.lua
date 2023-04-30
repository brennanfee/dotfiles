-- Colorschemes
local utils = require("core/utils")
local settings = require("core/user-settings")

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
          style = utils.safeRead(settings.themeVariant, "dark"),
          code_style = {
            keywords = 'bold',
          },
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
