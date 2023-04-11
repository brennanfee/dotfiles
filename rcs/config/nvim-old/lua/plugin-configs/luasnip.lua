local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath('config') .. '/snippets', }
})
