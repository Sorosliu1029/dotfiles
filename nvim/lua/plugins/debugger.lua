return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      local dap = require("dap")
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<Leader>db", dap.set_breakpoint, { desc = "Set breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
    end,
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- setup for new added dap
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("lazydev").setup({
        library = { "nvim-dap-ui" },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
