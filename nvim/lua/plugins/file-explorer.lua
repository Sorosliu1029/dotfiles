return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  init = function()
    vim.keymap.set("n", "<C-n>", "<Cmd>Neotree filesystem reveal left<CR>", { desc = "Open file explorer" })
  end,
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ["o"] = "system_open",
        },
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        vim.fn.jobstart({ "open", path }, { detach = true })
        -- Linux: open file in default application
        -- vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      end,
    },
  },
}
