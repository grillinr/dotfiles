return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- Load at startup if this is the main colorscheme
    priority = 1000, -- Load before all other start plugins
    config = function()
      require("github-theme").setup({
        -- You can add additional settings here if needed
      })

      vim.cmd("colorscheme github_dark") -- Set the colorscheme
    end,
  },
}
