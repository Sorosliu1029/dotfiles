return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function()
      return {
        ensure_installed = require("configs.mason.packages").formatter,
        automatic_installation = false,
        handlers = {},
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      -- use only none-ls to format
      -- ref: https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
          async = false,
        })
      end

      vim.keymap.set("n", "<leader>gf", lsp_formatting, { desc = "Format this buffer" })

      -- format on save, in a Sync way
      -- ref: https://github.com/nvimtools/none-ls.nvim/wiki/Formatting-on-save#sync-formatting
      -- you can reuse a shared lspconfig on_attach callback here
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      ---@diagnostic disable-next-line: unused-local, unused-function
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end

      null_ls.setup({
        sources = {
          -- Code Action
          --
          -- Injects code actions for Git operations at the current cursor position (stage / preview / reset hunks, blame, etc.).
          null_ls.builtins.code_actions.gitsigns,

          -- Completion
          --

          -- Formatting
          --
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.codespell,
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,

          -- Diagnostic
          --
          null_ls.builtins.diagnostics.codespell,
        },

        on_attach = nil,
      })
    end,
  },
}
