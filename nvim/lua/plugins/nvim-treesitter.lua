return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
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
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- Your custom capture.
							-- ["aF"] = "@custom_capture",

							-- Built-in captures.
							["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
							["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						},
					},
				},
			})
		end,
	},
}
