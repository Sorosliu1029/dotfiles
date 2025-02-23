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
    init = function()
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format this buffer" })
    end,
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- Code Action
          --
          -- Injects code actions for Git operations at the current cursor position (stage / preview / reset hunks, blame, etc.).
          null_ls.builtins.code_actions.gitsigns,

          -- Completion
          --
          -- Remove `Text`field from completion candidates
          -- ref: https://www.reddit.com/r/neovim/comments/v2ifpb/text_fields_on_lsp_auto_completion/
          -- null_ls.builtins.completion.spell,

          -- Formatting
          --
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.codespell,
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
