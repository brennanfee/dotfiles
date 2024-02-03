local M = {
  "smoka7/hop.nvim",
  version = "*", -- optional but strongly recommended
  event = "VeryLazy",
}

function M.config()
  require("hop").setup()

  local map = require("core.utils").keymap
  local hop = require("hop")
  local directions = require("hop.hint").HintDirection
  local positions = require("hop.hint").HintPosition

  -- Better f and t
  map("n", "f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, { remap = true, desc = "Search [F]or Letter In Line" })

  map("n", "F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, { remap = true, desc = "Search [F]or Letter In Line (Backwards)" })

  map("n", "t", function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
      hint_offset = -1,
    })
  end, { remap = true, desc = "Search Up [T]o Letter In Line" })

  map("n", "T", function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
      hint_offset = -1,
    })
  end, { remap = true, desc = "Search Up [T]o Letter In Line (Backwards)" })

  -- Hop mappings
  map("n", "gj", function()
    hop.hint_char2()
  end, { desc = "[G]o To [C]haracter Combination" })

  map("n", "<leader>hc", function()
    hop.hint_char2()
  end, { desc = "[H]op To [C]haracter Combination" })

  map("n", "<leader>hl", function()
    hop.hint_lines_skip_whitespace()
  end, { desc = "[H]op To [L]ine" })

  map("n", "<leader>hs", function()
    hop.hint_lines()
  end, { desc = "[H]op To [L]ine [S]tart" })

  map("n", "<leader>hp", function()
    hop.hint_patterns()
  end, { desc = "[H]op To [P]attern" })

  map("n", "<leader>hw", function()
    hop.hint_words()
  end, { desc = "[H]op To [W]ord" })

  map("n", "<leader>hj", function()
    hop.hint_words({ current_line_only = true })
  end, { desc = "[J]ump To Word In Line" })

  map("n", "<leader>hk", function()
    hop.hint_words({ current_line_only = true, hint_position = positions.END })
  end, { desc = "[J]ump To Word In Line (End Of Word)" })
end

return M
