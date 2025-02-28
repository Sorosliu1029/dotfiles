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
  },
  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup({
        -- use nvim for simple java coding, otherwise IntelliJ plz
        java_test = { enable = false },
        java_debug_adapter = { enable = false },
        spring_boot_tools = { enable = false },
        notifications = { dap = false },
      })

      -- enable completion on lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig").jdtls.setup({
        capabilities = capabilities,
      })
    end,
  },
}
