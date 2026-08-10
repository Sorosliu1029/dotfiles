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
    -- FIX: `client.is_stopped` deprecation
    -- ref: https://github.com/zbirenbaum/copilot-cmp/issues/131#issuecomment-4360660251
    config = function()
      -- 1. Load the internal source file
      local copilot_source = require("copilot_cmp.source")
      -- 2. Monkeypatch the method to use the new colon (:) syntax
      copilot_source.is_available = function(self)
        if self.client:is_stopped() or not (self.client.name == "copilot") then
          return false
        end

        local get_source_client = function()
          if vim.lsp.get_clients == nil then
            return vim.lsp.get_active_clients({
              bufnr = vim.api.nvim_get_current_buf(),
              id = self.client.id,
            })
          end
          return vim.lsp.get_clients({
            bufnr = vim.api.nvim_get_current_buf(),
            id = self.client.id,
          })
        end
        return next(get_source_client()) ~= nil
      end
      -- 3. Run the original setup function safely
      require("copilot_cmp").setup()
    end,
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
