return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ast_grep",
          "clangd",
          "jedi_language_server",
          "gopls",
          "bashls",
          "harper_ls",
          "cmake",
          "cssls",
          "tailwindcss",
          "dockerls",
          "hls",
          "eslint",
          "jdtls",
          "ts_ls",
          "jsonls",
          "julials",
          "textlsp",
          "ltex",
          "buf_ls",
          "sqlls",
          "grammarly",
          "vimls",
          "yamlls",
          "pyright",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.jdtls.setup({ capabilities = capabilities })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover to show symbol under cursor" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
  -- java lsp: jdtls
  {
    "mfussenegger/nvim-jdtls",
  },
}
