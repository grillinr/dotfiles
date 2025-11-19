-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

-- Open office docs in LibreOffice
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.docx", "*.xlsx", "*.pptx" },
  callback = function()
    vim.fn.jobstart({ "libreoffice", vim.fn.expand("%") }, { detach = true })
    vim.cmd("bdelete")
  end,
})

-- Open PDFs in zathura
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.pdf" },
  callback = function()
    vim.fn.jobstart({ "zathura", vim.fn.expand("%") }, { detach = true })
    vim.cmd("bdelete")
  end,
})

-- Preview images inline
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.jpg", "*.jpeg", "*.png", "*.gif", "*.bmp", "*.tiff" },
--   callback = function()
--     require("image_preview").PreviewImage(vim.fn.expand("%"))
--   end,
-- })
