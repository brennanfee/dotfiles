-- Comment plugin ('gc' and 'gcc' to comment/uncomment)

return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = {
       'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require("Comment").setup({
        ignore = '^$',
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
}
