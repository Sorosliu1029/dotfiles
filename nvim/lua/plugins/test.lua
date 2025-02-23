return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      -- see: https://github.com/nvim-neotest/neotest?tab=readme-ov-file#supported-runners

      -- require("neotest-python")({
      --   dap = { justMyCode = false },
      -- }),
      -- require("neotest-plenary"),
      -- require("neotest-vim-test")({
      --   ignore_file_types = { "python", "vim", "lua" },
      -- }),
    },
  },
}
