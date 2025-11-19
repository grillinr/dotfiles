return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
        },
        never_show = { ".git" },
      },
      window = {
        mappings = {
          ["<leader>p"] = "image_preview",
        },
      },
      commands = {
        image_preview = function(state)
          local node = state.tree:get_node()
          if node.type == "file" then
            local ok, image = pcall(require, "image")
            if ok then
              image.from_file(node.path):render()
            else
              vim.notify("Image plugin not loaded: " .. image, vim.log.levels.ERROR)
            end
          end
        end,
      },
    },
  },
}
