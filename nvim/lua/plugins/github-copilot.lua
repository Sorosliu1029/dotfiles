return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lualine/lualine.nvim",
    },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("copilot_status").setup({
        icons = {
          idle = " ",
          error = " ",
          offline = " ",
          warning = "𥉉 ",
          loading = " ",
        },
        debug = false,
      })
    end,
  },
}
