-- Autocompletion & Snipit plugins

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)

          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = vim.g.vscode_snippets_path or "",
          })

          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()
          require("luasnip.loaders.from_snipmate").lazy_load({
            paths = vim.g.snipmate_snippets_path or "",
          })

          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },
      config = function()
        local cmp = require("cmp")

        cmp.setup({
          completion = {
            completeopt = "menu,menuone",
          },

          window = {
            completion = {
              side_padding = 0,
              winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
              scrollbar = false,
              border = border("CmpBorder"),
            },
            documentation = {
              border = border("CmpDocBorder"),
              winhighlight = "Normal:CmpDoc",
            },
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },

          formatting = {
            -- default fields order i.e completion word + item.kind + item.kind icons
            fields = { "abbr", "kind", "menu" },

            format = function(_, item)
              local icons = require("core.icons").lspkind
              local icon = icons[item.kind] or ""

              icon = " " .. icon .. " "
              item.kind = string.format("%s %s", icon, item.kind or "")

              return item
            end,
          },

          mapping = {
            -- ["<C-p>"] = cmp.mapping.select_prev_item(),
            -- ["<C-n>"] = cmp.mapping.select_next_item(),
            -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
            -- ["<C-Space>"] = cmp.mapping.complete(),
            -- ["<leader>cc"] = cmp.mapping.complete(),
            -- ["<C-e>"] = cmp.mapping.close(),
            -- ["<CR>"] = cmp.mapping.confirm {
            --   behavior = cmp.ConfirmBehavior.Replace,
            --   select = false,
            -- },
            -- ["<Tab>"] = cmp.mapping(function(fallback)
            --   if cmp.visible() then
            --     cmp.select_next_item()
            --   elseif require("luasnip").expand_or_jumpable() then
            --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            --   else
            --     fallback()
            --   end
            -- end, {
            --   "i",
            --   "s",
            -- }),
            -- ["<S-Tab>"] = cmp.mapping(function(fallback)
            --   if cmp.visible() then
            --     cmp.select_prev_item()
            --   elseif require("luasnip").jumpable(-1) then
            --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            --   else
            --     fallback()
            --   end
            -- end, {
            --   "i",
            --   "s",
            -- }),
          },

          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "path" },
            { name = "cmdline" },
          },
        })
      end,
    },
  },
}
