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
					"google-java-format",
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
					-- Remove `Text`field from completion candidates
					-- ref: https://www.reddit.com/r/neovim/comments/v2ifpb/text_fields_on_lsp_auto_completion/
					-- null_ls.builtins.completion.spell,

					require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
				},
			})
		end,
	},
	{
		"nvimtools/none-ls-extras.nvim",
	},
}
