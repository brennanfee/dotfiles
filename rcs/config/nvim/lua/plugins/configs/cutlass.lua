
return {
  {
    "gbprod/cutlass.nvim",
    init = function()
      require("core.utils").lazy_load "cutlass.nvim"
    end,
    opts = {
    },
  },
}
