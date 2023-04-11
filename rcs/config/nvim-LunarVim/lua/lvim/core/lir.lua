local M = {}

M.config = function()
  local utils = require "lvim.utils.modules"
  local actions = utils.require_on_exported_call "lir.actions"
  local clipboard_actions = utils.require_on_exported_call "lir.clipboard.actions"

  lvim.builtin.lir = {
    active = true,
    on_config_done = nil,
    icon = "",
    show_hidden_files = false,
    ignore = {}, -- { ".DS_Store" "node_modules" } etc.
    devicons = {
      enable = true,
      highlight_dirname = true,
    },
    mappings = {
      ["l"] = actions.edit,
      ["<CR>"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["v"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,

      ["h"] = actions.up,
      ["q"] = actions.quit,

      ["A"] = actions.mkdir,
      ["a"] = actions.newfile,
      ["r"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["i"] = actions.toggle_show_hidden,
      ["d"] = actions.delete,

      ["J"] = function()
        require("lir.mark.actions").toggle_mark()
        vim.cmd "normal! j"
      end,
      ["c"] = clipboard_actions.copy,
      ["x"] = clipboard_actions.cut,
      ["p"] = clipboard_actions.paste,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = false,
        highlight_dirname = true,
      },

      -- You can define a function that returns a table to be passed as the third
      -- argument of nvim_open_win().
      win_opts = function()
        local width = math.floor(vim.o.columns * 0.7)
        local height = math.floor(vim.o.lines * 0.7)
        return {
          border = "rounded",
          width = width,
          height = height,
        }
      end,
    },
    hide_cursor = false,
    on_init = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )
    end,
  }
end

function M.icon_setup()
  local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
  if not devicons_ok then
    return
  end

  local function get_hl_by_name(name)
    local ret = vim.api.nvim_get_hl_by_name(name.group, true)
    return string.format("#%06x", ret[name.property])
  end

  local found, icon_hl = pcall(get_hl_by_name, { group = "NvimTreeFolderIcon", property = "foreground" })
  if not found then
    icon_hl = "#42A5F5"
  end

  devicons.set_icon {
    lir_folder_icon = {
      icon = lvim.builtin.lir.icon,
      color = icon_hl,
      name = "LirFolderNode",
    },
  }
end

function M.setup()
  local status_ok, lir = pcall(reload, "lir")
  if not status_ok then
    return
  end

  if not lvim.use_icons then
    lvim.builtin.lir.devicons.enable = false
  end

  lir.setup(lvim.builtin.lir)
  M.icon_setup()

  if lvim.builtin.lir.on_config_done then
    lvim.builtin.lir.on_config_done(lir)
  end
end

return M
