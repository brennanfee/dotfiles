local M = {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    keymap = { preset = "default" },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = false },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}

M._setupIcons = function(opts)
  -- Currently only support minin.icons (preferred) and nvim-web-devicions/lspkind
  local mini_ok, mini = pcall(require, "mini.icons")
  if mini_ok then
    opts.completion.menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = mini.get("lsp", ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = mini.get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      },
    }
  else
    local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
    local lspkind_ok, lspkind = pcall(require, "lspkind")
    if devicons_ok then
      opts.completion.menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = devicons.get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  if lspkind_ok then
                    icon = lspkind.symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end
                end

                return icon .. ctx.icon_gap
              end,

              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = devicons.get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      }
    end
  end

  return opts
end

M.config = function(_, opts)
  local blink = require("blink.cmp")

  opts = M._setupIcons(opts)

  blink.setup(opts)
end

return M

-- local M = {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     {
--       "hrsh7th/cmp-nvim-lsp",
--       event = "InsertEnter",
--     },
--     {
--       "hrsh7th/cmp-emoji",
--       event = "InsertEnter",
--     },
--     {
--       "hrsh7th/cmp-buffer",
--       event = "InsertEnter",
--     },
--     {
--       "hrsh7th/cmp-path",
--       event = "InsertEnter",
--     },
--     {
--       "hrsh7th/cmp-cmdline",
--       event = "InsertEnter",
--     },
--     {
--       "saadparwaiz1/cmp_luasnip",
--       event = "InsertEnter",
--     },
--     {
--       "L3MON4D3/LuaSnip",
--       version = "v2.*",
--       event = "InsertEnter",
--       dependencies = {
--         "rafamadriz/friendly-snippets",
--       },
--       build = "make install_jsregexp",
--     },
--     {
--       "hrsh7th/cmp-nvim-lua",
--     },
--   },
-- }

-- function M.config()
--   local cmp = require("cmp")
--   local luasnip = require("luasnip")

--   ------ Luasnip config ------
--   luasnip.config.set_config({
--     history = true,
--     --updateevents = { "TextChanged,TextChangedI" },
--     updateevents = { "TextChangedI" },
--   })

--   -- Vscode format
--   require("luasnip.loaders.from_vscode").lazy_load({
--     paths = vim.g.vscode_snippets_path or "",
--   })

--   -- Snipmate format
--   require("luasnip.loaders.from_snipmate").lazy_load({
--     paths = vim.g.snipmate_snippets_path or "",
--   })

--   -- Lua format
--   require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

--   local LuaSnipCursorHoldGrp = vim.api.nvim_create_augroup("LuaSnipCursorHoldGrp", { clear = true })
--   vim.api.nvim_create_autocmd({ "CursorHold" }, {
--     group = LuaSnipCursorHoldGrp,
--     callback = function()
--       local status_ok, luasnip2 = pcall(require, "luasnip")
--       if not status_ok then
--         return
--       end
--       if luasnip2.expand_or_jumpable() then
--         -- Ask maintainer for option to make this silent
--         -- luasnip.unlink_current()
--         vim.cmd([[silent! lua require("luasnip").unlink_current()]])
--       end
--     end,
--   })

--   ------ Cmp Config ------

--   -- TODO: Use theme colors
--   vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
--   vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
--   vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

--   local check_backspace = function()
--     local col = vim.fn.col(".") - 1
--     return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
--   end

--   local icons = require("data.icons")

--   cmp.setup({
--     snippet = {
--       expand = function(args)
--         luasnip.lsp_expand(args.body) -- For `luasnip` users.
--       end,
--     },
--     mapping = cmp.mapping.preset.insert({
--       ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
--       ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
--       ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
--       ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
--       ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--       ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--       ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--       ["<C-e>"] = cmp.mapping({
--         i = cmp.mapping.abort(),
--         c = cmp.mapping.close(),
--       }),
--       -- Accept currently selected item. If none selected, `select` first item.
--       -- Set `select` to `false` to only confirm explicitly selected items.
--       ["<CR>"] = cmp.mapping.confirm({ select = false }),
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         -- if cmp.visible() then
--         --   cmp.select_next_item()
--         -- elseif luasnip.locally_jumpable(1) then
--         if luasnip.locally_jumpable(1) then
--           luasnip.jump(1)
--         elseif check_backspace() then
--           fallback()
--           -- require("neotab").tabout()
--         else
--           fallback()
--           -- require("neotab").tabout()
--         end
--       end, {
--         "i",
--         "s",
--       }),
--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         -- if cmp.visible() then
--         --   cmp.select_prev_item()
--         -- elseif luasnip.locally_jumpable(-1) then
--         if luasnip.locally_jumpable(-1) then
--           luasnip.jump(-1)
--         elseif check_backspace() then
--           fallback()
--           -- require("neotab").tabout()
--         else
--           fallback()
--           -- require("neotab").tabout()
--         end
--       end, {
--         "i",
--         "s",
--       }),
--     }),
--     formatting = {
--       fields = { "kind", "abbr", "menu" },
--       format = function(entry, vim_item)
--         vim_item.kind = icons.kind[vim_item.kind]
--         vim_item.menu = ({
--           nvim_lsp = "",
--           nvim_lua = "",
--           luasnip = "",
--           buffer = "",
--           path = "",
--           emoji = "",
--         })[entry.source.name]

--         if entry.source.name == "emoji" then
--           vim_item.kind = icons.misc.Smiley
--           vim_item.kind_hl_group = "CmpItemKindEmoji"
--         end

--         if entry.source.name == "cmp_tabnine" then
--           vim_item.kind = icons.misc.Robot
--           vim_item.kind_hl_group = "CmpItemKindTabnine"
--         end

--         return vim_item
--       end,
--     },
--     sources = {
--       -- { name = "copilot" },
--       { name = "nvim_lsp" },
--       { name = "luasnip" },
--       { name = "cmp_tabnine" },
--       { name = "nvim_lua" },
--       { name = "buffer" },
--       { name = "path" },
--       { name = "calc" },
--       { name = "emoji" },
--       { name = "cmdline" },
--     },
--     confirm_opts = {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = false,
--     },
--     window = {
--       completion = {
--         border = "rounded",
--         scrollbar = false,
--       },
--       documentation = {
--         border = "rounded",
--       },
--     },
--     experimental = {
--       ghost_text = false,
--     },
--   })
-- end

-- return M
