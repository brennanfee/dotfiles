local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local has_dapui, dapui = pcall(require, "dapui")
if not has_dapui then
  return
end

local dapui_config = {
  layouts = {
    {
      elements = {
        { id = "stacks", size = 0.3 },
        { id = "watches", size = 0.3 },
        { id = "breakpoints", size = 0.3 },
      },
      size = 40,
      position = "right",
    },
    {
      elements = { "scopes" },
      size = 10,
      position = "bottom",
    },
  },
}

dapui.setup(dapui_config)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DapBreakpointConditional', linehl='', numhl='DapBreakpointConditional'})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapBreakpointRejected', linehl='', numhl='DapBreakpointRejected'})
vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='DapStoppedLine', numhl='DapStopped'})

local has_dap_vt, dapvt = pcall(require, "nvim-dap-virtual-text")
if has_dapui then
  dapvt.setup()
end

local has_telescope, telescipe = pcall(require, "telescope")
if has_telescope then
  telescipe.load_extension('dap')
end
