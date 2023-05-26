-- Terminal plugins, tmux, etc.

return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      --vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          _G.set_terminal_keymaps()
        end,
        desc = "Mappings for navigation with a terminal",
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      vim.api.nvim_create_user_command("LazyGitToggle", function()
        lazygit:toggle()
      end, { desc = "Toggle LazyGit terminal" })

      local node = Terminal:new({ cmd = "node", hidden = true })

      vim.api.nvim_create_user_command("NodeToggle", function()
        node:toggle()
      end, { desc = "Toggle Node terminal" })

      local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

      vim.api.nvim_create_user_command("NCDUToggle", function()
        ncdu:toggle()
      end, { desc = "Toggle NCDU terminal" })

      vim.api.nvim_create_user_command("NcduToggle", function()
        ncdu:toggle()
      end, { desc = "Toggle NCDU terminal" })

      local htop = Terminal:new({ cmd = "htop", hidden = true })

      vim.api.nvim_create_user_command("HtopToggle", function()
        htop:toggle()
      end, { desc = "Toggle htop terminal" })

      local python = Terminal:new({ cmd = "python", hidden = true })

      vim.api.nvim_create_user_command("PythonToggle", function()
        python:toggle()
      end, { desc = "Toggle Python terminal" })
    end,
  },
}
