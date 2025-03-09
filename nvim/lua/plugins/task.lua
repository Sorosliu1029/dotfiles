return {
  "stevearc/overseer.nvim",
  keys = {
    { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Overseer: Select and start a task" },
    { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Overseer: Open the task list" },
  },
  opts = {
    -- Integrate with 'toggleterm'
    -- ref: https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#toggleterm
    strategy = "toggleterm",
  },
}
