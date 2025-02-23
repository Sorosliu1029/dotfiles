return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {},
  },
  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lualine/lualine.nvim",
    },
    lazy = true,
    event = "BufReadPost",
    opts = {
      icons = {
        idle = " ",
        error = " ",
        offline = " ",
        warning = "𥉉 ",
        loading = " ",
      },
      debug = false,
    },
  },
}
