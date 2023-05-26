-- Project management plugins

return {
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "package.json",
          ".terraform",
          "go.mod",
          "Makefile",
          "requirements.yml",
          "pyproject.toml",
        },

        ---@ Show hidden files in telescope when searching for files in a project
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,
      })

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("projects")
    end,
  },
}
