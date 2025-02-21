return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Opt to list sources here, when available in mason.
					"stylua",
					"jq",
					"prettier",
					"eslint_d",
					"black",
					"isort",
					"cspell",
				},
				automatic_installation = false,
				handlers = {},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		init = function()
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format this buffer" })
		end,
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.completion.spell,
					require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
				},
			})
		end,
	},
	{
		"nvimtools/none-ls-extras.nvim",
	},
}
