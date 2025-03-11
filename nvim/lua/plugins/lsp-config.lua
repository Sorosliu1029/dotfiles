return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = require("configs.mason.packages").lsp,
      -- A "default handler" to the handlers option so we can get automatic setup
      -- for all the language servers installed with mason.nvim
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        jdtls = function() end, -- We don't want to start jdtls here
        clangd = function()
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup({
            cmd = { "clangd", "--offset-encoding=utf-16" },
          })
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        -- 1. Add cmp_nvim_lsp capabilities settings to lspconfig
        require("cmp_nvim_lsp").default_capabilities(),
        -- 2. Tell the server the capability of foldingRange (by 'nvim-ufo')
        { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
      )
      local lspconfig_defaults = lspconfig.util.default_config
      -- This should be executed before you configure any language server
      lspconfig_defaults.capabilities = vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, lsp_capabilities)

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover to show symbol under cursor", buffer = event.buf })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = event.buf })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = event.buf })
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = event.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "List all implementations", buffer = event.buf })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List all references", buffer = event.buf })
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Display signature information", buffer = event.buf })
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = event.buf })
        end,
      })
    end,
  },
}
