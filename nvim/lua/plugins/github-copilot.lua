return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    opts = {},
  },
  {
    "AndreM222/copilot-lualine",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lualine/lualine.nvim",
    },
    lazy = true,
    event = "BufReadPost",
  },
}
