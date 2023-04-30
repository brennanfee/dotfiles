
-- Adds git releated signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns.txt`
return {
  {
    'lewis6991/gitsigns.nvim',
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = {
      signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
      on_attach = function(bufnr)
        -- Navigation through hunks
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            require("gitsigns").next_hunk()
          end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Jump to next hunk" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            require("gitsigns").prev_hunk()
          end)
          return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Jump to prev hunk" })

        -- Actions
        vim.keymap.set("n", "<leader>rh", function()
          require("gitsigns").reset_hunk()
        end, { buffer = bufnr, desc = "Reset hunk" })

        vim.keymap.set("n", "<leader>ph", function()
          require("gitsigns").preview_hunk()
        end, { buffer = bufnr, desc = "Preview hunk" })

        vim.keymap.set("n", "<leader>gb", function()
          require("gitsigns").blame_line()
        end, { buffer = bufnr, desc = "Blame line" })

        vim.keymap.set("n", "<leader>td", function()
          require("gitsigns").toggle_deleted()
        end, { buffer = bufnr, desc = "Toggle deleted" })
      end,
    },
  },
}
