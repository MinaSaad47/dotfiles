return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-tree/nvim-tree.lua",
      config = function()
        local status_ok, nvim_tree_events = pcall(require, "nvim-tree.events")
        if status_ok then
          local bufferline_state = require "bufferline.api"

          nvim_tree_events.on_tree_open(function()
            bufferline_state.set_offset(31, "File Tree")
          end)

          nvim_tree_events.on_tree_close(function()
            bufferline_state.set_offset(0)
          end)
        end
      end,
    },
  }, -- status line
}
