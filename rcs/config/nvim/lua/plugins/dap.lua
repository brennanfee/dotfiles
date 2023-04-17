-- Debugging settings including DAP plugin

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
--    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Show debug values in virtual text
    "theHamsta/nvim-dap-virtual-text",

    -- Add other debuggers here
    'leoluz/nvim-dap-go',
  },
config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup {
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        "bash",
--        "coreclr", -- not supported on Linux, what a joke
        "cppdbg",
--        "chrome", -- this one seems to be broken
        "delve", -- this one is for go
        "firefox",
        "javadbg",
        "js",
        "kotlin",
        "node2",
        "php",
        "python",
      },

      automatic_installation = true,

      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
    }

    -- Basic debugging keymaps
    vim.keymap.set('n', '<F8>', dap.continue)
    vim.keymap.set('n', '<F5>', dap.step_into)
    vim.keymap.set('n', '<F6>', dap.step_over)
    vim.keymap.set('n', '<F7>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
