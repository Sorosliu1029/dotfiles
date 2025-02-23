return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  init = function()
    -- remove Neo-tree from resotre
    -- ref: https://github.com/folke/persistence.nvim/issues/80#issuecomment-2506424807
    vim.opt.sessionoptions:remove("blank")

    vim.keymap.set("n", "<leader>qs", function()
      require("persistence").load()
    end, { desc = "Load the session for the current directory" })

    vim.keymap.set("n", "<leader>qS", function()
      require("persistence").select()
    end, { desc = "Select a session to load" })

    vim.keymap.set("n", "<leader>ql", function()
      require("persistence").load({ last = true })
    end, { desc = "Load the last session" })

    vim.keymap.set("n", "<leader>qd", function()
      require("persistence").stop()
    end, { desc = "Stop Persistence => session won't be saved on exit" })
  end,
  opts = {
    -- add any custom options here
  },
}
