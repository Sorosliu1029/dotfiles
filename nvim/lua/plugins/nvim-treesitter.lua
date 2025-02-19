return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"heex",
					"javascript",
					"html",
					"css",
					"java",
					"python",
					"julia",
					"cpp",
					"json",
					"yaml",
					"typescript",
					"bash",
					"haskell",
					"go",
					"latex",
					"rust",
					"cmake",
					"dockerfile",
					"git_config",
					"gitattributes",
					"gitignore",
					"ispc",
					"jinja",
					"jq",
					"make",
					"proto",
					"sql",
					"ssh_config",
					"tmux",
					"xml",
					"markdown",
					"markdown_inline",
					"regex",
				},
				auto_install = true,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- folding, ref: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldminlines = 5
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
