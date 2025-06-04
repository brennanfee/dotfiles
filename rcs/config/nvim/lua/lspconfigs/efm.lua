local M = function()
  local languages = require("efmls-configs.defaults").languages()

  -- languages = vim.tbl_extend('force', languages, {
  --   = = {
  --   }
  --   abc = {
  --     { lintCommand = "editorconfig-checker", lintStdin = true },
  --   }
  -- })

  local efmls_config = {
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = { ".git/" },
      languages = languages,
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
  }

  return efmls_config
end

return M
