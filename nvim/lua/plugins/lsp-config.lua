return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return { ensure_installed = require("configs.mason.packages").lsp }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover to show symbol under cursor" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
    config = function()
      -- enable completion on lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      local language_servers = require("configs.lsp.servers").to_setup
      for _, ls in ipairs(language_servers) do
        lspconfig[ls].setup({
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        })
      end
    end,
  },
}
