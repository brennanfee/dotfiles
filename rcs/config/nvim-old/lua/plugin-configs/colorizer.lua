local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
  return
end

colorizer.setup({
    '*'; -- Highlight all files, but customize some others.
    css = { names = true; };
    html = { names = true; };
  },
  -- Default opts for all files
  {
    names = false,
    mode = 'background',
    --mode = 'virtualtext',
  }
)

-- Set a filetype for palette files so Colorizer attaches on open
vim.cmd [[ au BufReadPost *.palette setlocal ft=palette ]]
