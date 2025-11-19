vim.opt.mouse = "v"
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.filetype.add({
  filename = {
    [".env"] = "dotenv",
  },
})
