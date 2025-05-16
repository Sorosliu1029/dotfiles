return {
  "nvimdev/dashboard-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {
    -- config
    theme = "hyper",
    hide = {
      statusline = false,
    },
    config = {
      week_header = {
        enable = true,
      },
      packages = { enable = false },
      shortcut = {
        { action = "Telescope find_files", desc = "Files", key = "f", icon = " ", icon_hl = "@variable", group = "Label" },
        { action = "ene | startinsert", desc = "New File", key = "n", icon = " ", icon_hl = "@variable", group = "Label" },
        { action = "lua require('telescope.builtin').oldfiles()", desc = "Recent Files", icon = " ", key = "r", icon_hl = "@variable", group = "Label" },
        { action = "lua require('telescope.builtin').live_grep()", desc = "Find Text", icon = " ", key = "g", group = "Number" },
        { action = "lua require('persistence').load()", desc = "Restore Session", icon = " ", key = "s", group = "String" },
        { action = "Lazy update", desc = "Update", key = "u", icon = "󰊳 ", group = "@property" },
        { action = "qa", desc = "Quit", icon = " ", key = "q" },
      },
      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return vim.split("\n⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms", "\n")
      end,
    },
  },
}
